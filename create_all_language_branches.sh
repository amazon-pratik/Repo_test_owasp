#!/bin/bash

# Script to create separate branches for each language from LLM_cases_manifest

set -e

# Configuration
SOURCE_DIR="/Users/praardha/IdeaProjects/QCAFE_automation_new/qcafe_automation/src/AWSGuruLLMBenchmarks/LLM_cases_manifest"
REPO_DIR="/Users/praardha/IdeaProjects/QCAFE_automation_new/Repo_test_owasp"

# All languages available in the manifest folder
LANGUAGES=("cpp" "csharp" "go" "java" "javascript" "kotlin" "php" "python" "ruby" "scala" "typescript")

echo "🚀 Creating separate branches for all LLM Benchmark languages..."
echo "📁 Source: $SOURCE_DIR"
echo "📦 Repository: $REPO_DIR"
echo ""

# Navigate to repository directory
cd "$REPO_DIR"

# Ensure we're on main branch
git checkout main
echo "✅ On main branch"

# Function to sanitize files (remove potential secrets)
sanitize_files() {
    local lang_dir="$1"
    echo "🧹 Sanitizing files in $lang_dir..."
    
    # Replace common secret patterns with placeholders
    find "$lang_dir" -type f \( -name "*.cs" -o -name "*.java" -o -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.rb" -o -name "*.go" -o -name "*.php" -o -name "*.cpp" -o -name "*.scala" -o -name "*.kt" \) -exec sed -i '' \
        -e 's/sk_test_[a-zA-Z0-9]*/sk_test_PLACEHOLDER_KEY/g' \
        -e 's/pk_test_[a-zA-Z0-9]*/pk_test_PLACEHOLDER_KEY/g' \
        -e 's/rk_test_[a-zA-Z0-9]*/rk_test_PLACEHOLDER_KEY/g' \
        -e 's/AKIA[0-9A-Z]*/AKIA_PLACEHOLDER_ACCESS_KEY/g' \
        -e 's/[0-9a-f]\{40\}/PLACEHOLDER_SECRET_40_CHARS/g' \
        -e 's/[0-9a-f]\{32\}/PLACEHOLDER_SECRET_32_CHARS/g' \
        {} \; 2>/dev/null || true
}

# Function to create README for each language
create_language_readme() {
    local lang="$1"
    local lang_dir="$2"
    local file_count="$3"
    local cwe_count="$4"
    local lang_upper=$(echo "$lang" | tr '[:lower:]' '[:upper:]')
    
    cat > "$lang_dir/README.md" << EOF
# $lang_upper LLM Benchmarks

This directory contains LLM benchmark test cases for **$lang** programming language.

## Overview

This collection includes security vulnerability test cases and best practices for $lang development, organized by CWE (Common Weakness Enumeration) categories.

## Structure

- **Test Cases**: $file_count $lang files
- **CWE Categories**: $cwe_count different vulnerability categories
- **Coverage**: Security vulnerabilities, coding best practices, and common pitfalls

## Categories Included

$(find "$lang_dir" -maxdepth 1 -type d -name "CWE-*" -o -name "Best_Practices" 2>/dev/null | sort | sed 's|.*/||' | sed 's/^/- /' || echo "- Various CWE categories and best practices")

## Usage

These test cases are designed to:

1. **Train LLM models** on secure coding practices
2. **Benchmark model performance** in identifying security vulnerabilities  
3. **Validate code analysis tools** for $lang
4. **Educational purposes** for secure $lang development

## File Naming Convention

Files follow the pattern: \`{category}-{description}_{complexity}.{extension}\`

- **category**: CWE identifier or best practice category
- **description**: Brief description of the test case
- **complexity**: basic, intermediate, or advanced

## Contributing

When adding new test cases:

1. Follow the existing file naming convention
2. Include both positive and negative examples
3. Add appropriate comments explaining the vulnerability or best practice
4. Ensure code compiles and runs (where applicable)

## Security Focus Areas

The test cases cover various security domains:

- **Input Validation** (CWE-20, CWE-79, CWE-89)
- **Authentication & Authorization** (CWE-287, CWE-306, CWE-862)
- **Cryptography** (CWE-326, CWE-327, CWE-328)
- **Memory Management** (CWE-119, CWE-125, CWE-416)
- **Error Handling** (CWE-209, CWE-252, CWE-754)
- **And many more...**

---

*Part of the AWS Guru LLM Benchmarks project for improving AI-assisted secure coding.*
EOF
}

# Process each language
for lang in "${LANGUAGES[@]}"; do
    echo ""
    echo "🔧 Processing language: $lang"
    
    # Check if source directory exists
    if [ ! -d "$SOURCE_DIR/$lang" ]; then
        echo "⚠️  Warning: Source directory for $lang not found, skipping..."
        continue
    fi
    
    # Create feature branch for this language
    branch_name="feature/llm-benchmarks-$lang"
    echo "📋 Creating branch: $branch_name"
    
    # Create new branch from main (or checkout if exists)
    git checkout main
    git branch -D "$branch_name" 2>/dev/null || true  # Delete if exists
    git checkout -b "$branch_name"
    
    # Create language directory structure
    lang_dir="LLM_cases_manifest/$lang"
    mkdir -p "$lang_dir"
    
    # Copy language files from source
    echo "📁 Copying $lang files..."
    cp -r "$SOURCE_DIR/$lang"/* "$lang_dir/"
    
    # Sanitize files to avoid secret scanning issues
    sanitize_files "$lang_dir"
    
    # Count files and directories
    file_count=$(find "$lang_dir" -type f 2>/dev/null | wc -l | tr -d ' ')
    cwe_count=$(find "$lang_dir" -maxdepth 1 -type d -name "CWE-*" 2>/dev/null | wc -l | tr -d ' ')
    
    echo "📊 Statistics: $file_count files, $cwe_count CWE categories"
    
    # Create language-specific README
    create_language_readme "$lang" "$lang_dir" "$file_count" "$cwe_count"
    
    # Add and commit changes for this language
    git add .
    git commit -m "feat($lang): Add LLM benchmark test cases for $lang

- Added comprehensive test cases covering security vulnerabilities
- Included CWE-based categorization for systematic coverage
- Added best practices examples for secure $lang development
- Created documentation for $lang-specific benchmarks
- Sanitized files to remove potential secrets

Categories: $cwe_count CWE categories
Files: $file_count test case files"

    # Push branch to remote with retry logic
    echo "📤 Pushing branch to remote..."
    max_retries=3
    retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if git push -u origin "$branch_name" --force; then
            echo "✅ Successfully pushed $branch_name"
            break
        else
            retry_count=$((retry_count + 1))
            echo "⚠️  Push failed (attempt $retry_count/$max_retries)"
            
            if [ $retry_count -eq $max_retries ]; then
                echo "❌ Failed to push $branch_name after $max_retries attempts"
                echo "   This might be due to secret scanning or other repository rules"
                echo "   You may need to manually review and push this branch"
            else
                echo "   Retrying in 5 seconds..."
                sleep 5
            fi
        fi
    done
    
    echo "✅ Completed processing for $lang"
done

echo ""
echo "🎉 Language branch creation completed!"
echo ""
echo "📋 Summary:"
echo "- Repository: https://github.com/amazon-pratik/Repo_test_owasp.git"
echo "- Languages processed: ${#LANGUAGES[@]}"
echo ""
echo "🌟 Branches created:"
for lang in "${LANGUAGES[@]}"; do
    if [ -d "$SOURCE_DIR/$lang" ]; then
        echo "  ✓ feature/llm-benchmarks-$lang"
    else
        echo "  ⚠ feature/llm-benchmarks-$lang (source not found)"
    fi
done
echo ""
echo "🔗 Next steps:"
echo "1. Go to GitHub repository: https://github.com/amazon-pratik/Repo_test_owasp"
echo "2. Create pull requests for each successfully pushed branch:"
for lang in "${LANGUAGES[@]}"; do
    if [ -d "$SOURCE_DIR/$lang" ]; then
        echo "   - feature/llm-benchmarks-$lang → main"
    fi
done
echo ""
echo "💡 Each branch contains:"
echo "- Language-specific test cases"
echo "- CWE-categorized security examples"
echo "- Comprehensive documentation"
echo "- Best practices examples"
echo "- Sanitized code (secrets replaced with placeholders)"
echo ""
echo "🚀 Ready to create pull requests on GitHub!"
echo ""
echo "📝 Note: If any branches failed to push due to secret scanning,"
echo "   you may need to manually review and sanitize those files further."