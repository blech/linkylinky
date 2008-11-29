require 'uri'
require 'test/unit'

def rule(text, schemes = nil)
    schemes = schemes.nil? ? nil : schemes.to_a
    uris = []
    URI.extract(text, schemes) { |uri|
        u = URI.parse(uri.gsub(/^URL:/, '').gsub(/,$/, ''))
        uris.push u.normalize.to_s
    }
    return uris
end

class TC_uri_find_rule < Test::Unit::TestCase
	png = 'http://ipy.frottage.org/rjp/2003/09/07/definitely.png'
	cgi = 'http://ipy.frottage.org/cgi-bin/rjp/env.cgi?query=frottage'
	fragment = 'http://ipy.frottage.org/rjp/#page1'
	ldap = 'ldap://server/o=frottage.org?uid?sub?(uid=%s)'
	news = 'news://news.easynet.co.uk/slrnbnntv2.1n95.rjp@ipy.frottage.org'
	nntp = 'nntp:slrnbnntv2.1n95.rjp@ipy.frottage.org'
	auth = 'http://rjp:badgers@ty.pi.st/secret/stash/'
	ssl = 'https://hotmail.com/'
	@@text = <<TEST_TEXT
this is some text with embedded links to people I know, http://plig.net/,
places I run, http://frottage.org/, helpful ftp sites, ftp://ftp.plig.org/,
a png that helps people to spell, #{png}, a cgi, #{cgi}, a page fragment, 
#{fragment}, and some miscellaneous other URLS -- #{ldap}, #{news}, #{nntp}, 
#{auth}, #{ssl}.
TEST_TEXT
    def test_http_scheme
        a = rule(@@text, 'http') 
        assert_equal(a.size, 6, '6 http urls')
    end
end

__END__

