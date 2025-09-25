
def bad1(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "'", "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "'", "" # NOT OK

# {/fact}
end

def bad2(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  /'/, "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! /'/, "" # NOT OK

# {/fact}
end

def bad3(s1, s2, s3)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /'/, "\\'"  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /'/, '\\\'' # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s2.gsub! /'/, "\\'"  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s3.gsub! /'/, '\\\'' # NOT OK

# {/fact}
end

def bad4(s1, s2, s3)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /'/, "\\\\\\&" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /'/, '\\\\\&'  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s2.gsub! /'/, "\\\\\\&" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s3.gsub! /'/, '\\\\\&'  # NOT OK

# {/fact}
end

def bad5(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub  /['"]/, '\\\\\&' # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub! /['"]/, '\\\\\&' # NOT OK

# {/fact}
end

def bad6(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub  /(['"])/, '\\\\\\1' # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub! /(['"])/, '\\\\\\1' # NOT OK

# {/fact}
end

def bad7(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub  /('|")/, '\\\\\1' # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.gsub! /('|")/, '\\\\\1' # NOT OK

# {/fact}
end

def bad8(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  '|', '' # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! '|', '' # NOT OK

# {/fact}
end

def bad9(s1, s2, s3, s4)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /"/, "\\\"" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  /"/, '\\"'  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s1.gsub  '"', '\\"'  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s2.gsub! /"/, "\\\"" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s3.gsub! /"/, '\\"'  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s4.gsub! '"', '\\"'  # NOT OK

# {/fact}
end

def bad10(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "/", "%2F" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "/", "%2F" # NOT OK

# {/fact}
end

def bad11(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "%25", "%" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "%25", "%" # NOT OK

# {/fact}
end

def bad12(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  %q['], %q[] # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! %q['], %q[] # NOT OK

# {/fact}
end

def bad13(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "'" + "", "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "'" + "", "" # NOT OK

# {/fact}
end

def bad14(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "'", "" + "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "'", "" + "" # NOT OK

# {/fact}
end

def bad15(s)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub  "'" + "", "" + "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub! "'" + "", "" + "" # NOT OK

# {/fact}
end

def bad16(s)
  indirect = /'/

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub(indirect, "")  # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub!(indirect, "") # NOT OK

# {/fact}
end

def good1a(s)
  until s.index("'").nil?

# {fact rule=autoescape-disabled@v1.0 defects=0}
    s = s.sub "'", "" # OK

# {/fact}
  end
  s
end

def good1b(s)
  until s.index("'").nil?

# {fact rule=autoescape-disabled@v1.0 defects=0}
    s.sub! "'", "" # OK

# {/fact}
  end
  s
end

def good2a(s)
  while s.index("'") != nil

# {fact rule=autoescape-disabled@v1.0 defects=0}
    s = s.sub /'/, "" # OK

# {/fact}
  end
  s
end

def good2b(s)
  while s.index("'") != nil

# {fact rule=autoescape-disabled@v1.0 defects=0}
    s.sub! /'/, "" # OK

# {/fact}
  end
  s
end

def good3a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub  "@user", "alice" # OK

# {/fact}
end

def good3b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub! "@user", "bob" # OK

# {/fact}
end

def good4a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub  /#/, "\\d+" # OK

# {/fact}
end

def good4b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! /#/, "\\d+" # OK

# {/fact}
end

def good5a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub(/\\/, "\\\\").gsub(/['"]/, '\\\\\&') # OK

# {/fact}
end

def good5b(s)
  s.gsub!(/\\/, "\\\\")

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub!(/['"]/, '\\\\\&') # OK

# {/fact}
end

def good6a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub(/[\\]/, '\\\\').gsub(/[\"]/, '\\"') # OK

# {/fact}
end

def good6b(s)
  s.gsub!(/[\\]/, '\\\\')

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub!(/[\"]/, '\\"') # OK

# {/fact}
end

def good7a(s)
  s = s.gsub /[\\]/, '\\\\'

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub /[\"]/, '\\"' # OK

# {/fact}
end

def good7b(s)
  s.gsub! /[\\]/, '\\\\'

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! /[\"]/, '\\"' # OK

# {/fact}
end

def good8a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub /\W/, '\\\\\&' # OK

# {/fact}
end

def good8b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! /\W/, '\\\\\&' # OK

# {/fact}
end

def good9a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub /[^\w\s]/, '\\\\\&' # OK

# {/fact}
end

def good9b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! /[^\w\s]/, '\\\\\&' # OK

# {/fact}
end

def good10a(s)
  s = s.gsub '\\', '\\\\'
  s = s.slice 1..(-1)
  s = s.gsub /\\"/, '"'

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s = s.gsub /'/, "\\'" # OK

# {/fact}
  "'" + s + "'"
end

def good10b(s)
  s.gsub! '\\', '\\\\'
  s.slice! 1..(-1)
  s.gsub! /\\"/, '"'

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! /'/, "\\'" # OK

# {/fact}
  "'" + s + "'"
end

def good11a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub '#', '💩' # OK

# {/fact}
end

def good11b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.gsub! '#', '💩' # OK

# {/fact}
end

def good12a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub "%d", "42" # OK

# {/fact}
end

def good12b(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub! "%d", "42" # OK

# {/fact}
end

def good13a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub('[', '').sub(']', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub('(', '').sub(')', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub('{', '').sub('}', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub('<', '').sub('>', '') # NOT OK: too common as a bad HTML sanitizer

# {/fact}


# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub('[', '\\[').sub(']', '\\]') # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  s.sub('{', '\\{').sub('}', '\\}') # NOT OK

# {/fact}


# {fact rule=autoescape-disabled@v1.0 defects=0}
  s = s.sub('[', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s = s.sub(']', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub(/{/, '').sub(/}/, '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub(']', '').sub('[', '') # probably OK, but still flagged

# {/fact}
end

def good13b(s1)
  s1.sub! '[', ''

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s1.sub! ']', '' # OK

# {/fact}
end

def good14a(s)

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub('"', '').sub('"', '') # OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s.sub("'", "").sub("'", "") # OK

# {/fact}
end

def good14b(s1, s2)
  s1.sub!('"', '')

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s1.sub!('"', '') # OK

# {/fact}

  s2.sub!("'", "")

# {fact rule=autoescape-disabled@v1.0 defects=0}
  s2.sub!("'", "") # OK

# {/fact}
end

def newlines_a(a, b, c)
  # motivation for whitelist

# {fact rule=autoescape-disabled@v1.0 defects=0}
  `which emacs`.sub("\n", "") # OK

# {/fact}


# {fact rule=autoescape-disabled@v1.0 defects=1}
  a.sub("\n", "").sub(b, c) # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  a.sub(b, c).sub("\n", "") # NOT OK

# {/fact}
end

def newlines_b(a, b, c)
  # motivation for whitelist
  output = `which emacs`

# {fact rule=autoescape-disabled@v1.0 defects=0}
  output.sub!("\n", "") # OK

# {/fact}

  d = a.dup

# {fact rule=autoescape-disabled@v1.0 defects=1}
  d.sub!("\n", "") # NOT OK

# {/fact}
  d.sub!(b, c)

  e = a.dup
  d.sub!(b, c)

# {fact rule=autoescape-disabled@v1.0 defects=1}
  d.sub!("\n", "") # NOT OK

# {/fact}
end

def bad_path_sanitizer(p1, p2)
  # attempt at path sanitization

# {fact rule=autoescape-disabled@v1.0 defects=1}
  p1.sub! "/../", "" # NOT OK

# {/fact}

# {fact rule=autoescape-disabled@v1.0 defects=1}
  p2.sub  "/../", "" # NOT OK

# {/fact}
end
