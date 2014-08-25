require 'formula'

class Pacparser < Formula
  homepage 'https://code.google.com/p/pacparser/'
  url 'https://pacparser.googlecode.com/files/pacparser-1.3.1.tar.gz'
  sha1 'eeaf890fddc16994d6063efe27a41488fa7f7ed9'
  head 'https://code.google.com/p/pacparser'

  depends_on 'python' if build.include? 'with-python'
  
  option 'with-python', 'Build python module'

  def install    
    system "make", "-C", "src"
    system "make", "-C", "src", "PREFIX=#{prefix}", "install"
    if build.include? 'with-python'
      system "make", "-C", "src", "pymod"
      system "make", "-C", "src", "PREFIX=#{prefix}", "install-pymod"
    end
  end

  test do
    system "curl -s -S 'http://pastebin.com/raw.php?i=1agYHQqD' | pactester -p - -u 'http://www.yourdomain.com'"
    if build.include? 'with-python'
      system "python -c 'import pacparser'"
    end
  end
end
