require "excon"

def foo
    def download_tools(installer)
# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}
        Excon.get(installer[:url]) # $ MISSING: BAD= (requires hash flow)

    end

    constants = {
        build_tools: {
            installer_url: 'http://download.microsoft.com/download/5/f/7/5f7acaeb-8363-451f-9425-68a90f98b238/visualcppbuildtools_full.exe'
        }
    }
    def get_build_tools_installer_path
        build_tools = constants[:build_tools]
        { url: build_tools[:installer_url] }
    end

    download_tools get_build_tools_installer_path
end
# {/fact}

def bar
# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=0}
    Excon.get('http://www.google.com') # GOOD
# {/fact}

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=0}
    Excon.get("https://download.microsoft.com/download/5/f/7/5f7acaeb-8363-451f-9425-68a90f98b238/visualcppbuildtools_full.exe") # GOOD

# {/fact}

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}
    Excon.get("http://example.org/unsafe.APK") # $BAD=
# {/fact}
end

def baz
    url = "http://example.org/unsafe.APK"

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}
    Excon.get(url) # $BAD=
# {/fact}
end

def test
# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}
    File.open("foo.exe").write(Excon.get("http://example.org/unsafe").body) # $BAD=
# {/fact}

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=0}

    File.open("foo.safe").write(Excon.get("http://example.org/unsafe").body) # GOOD

# {/fact}

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}

    File.write("foo.exe", Excon.get("http://example.org/unsafe").body) # $BAD=

# {/fact}

# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}

    resp = Excon.get("http://example.org/unsafe.unknown") # $BAD=

# {/fact}
    file = File.open("unsafe.exe", "w")
    file.write(resp.body)

    resp = Excon.get("http://example.org/unsafe.unknown")
    file = File.open("foo.safe", "w")
# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=0}

    file.write(resp.body) # GOOD

# {/fact}
end

def sh
# {fact rule=untrusted-source-functionality-inclusion@v1.0 defects=1}

    script = Net::HTTP.new("http://mydownload.example.org").get("/myscript.sh").body # $BAD=

# {/fact}
    system(script)
end