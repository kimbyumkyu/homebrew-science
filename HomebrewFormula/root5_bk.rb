class Root5Pung < Formula
  homepage "https://root.cern.ch"
  url "https://root.cern.ch/download/root_v5.34.36.macosx64-10.11-clang70.tar.gz"
  sha256 "6f604c04d415327f28e6a086b1e10bb10aa259325db5d4be6b2ff0062d764f4e"
  version "5.34.36"

  def install
    (prefix+'root').install Dir["*"]
    (libexec+'set_root5.sh').write  <<-EOS.undent
      alias useroot5="source #{prefix}/root/bin/thisroot.sh;which root"
      function root5(){ ( useroot5; exec root.exe "$@")}
      alias r5=root5
    EOS
    (libexec+'set_root5_pung.sh').write  <<-EOS.undent
      alias useroot5_pung="source #{prefix}/root/bin/thisroot.sh;which root"
      function root5_pung(){ ( useroot5_pung; exec root.exe "$@")}
    EOS
    (libexec+'root5_pung').write  <<-EOS.undent
      #!/bin/bash
      source #{prefix}/root/bin/thisroot.sh
      echo "#{prefix}/root/bin/root"
      exec #{prefix}/root/bin/root.exe "$@"
    EOS
    bin.install libexec+'root5_pung'
  end
  def caveats; <<-EOS.undent
    To use root5_pung, you have 3 options

    1. Just type "root5_pung". It's a small wraper script to run root.

    2. Put the next line into your .bash_profile. 
        . $(brew --prefix root5_pung)/libexec/set_root5_pung.sh
      This will make 2 alias/function
        * useroot5_pung : an alias to set root environment
        * root5_pung    : an function to run root without enviroment configurations.

    3. The next alternative way will generator even shorter command.
        . $(brew --prefix root5_pung)/libexec/set_root5.sh
       This will make
        * useroot5
        * root5
        * r5            : alias of root5

    A robust way to make them easy is just
        echo '. $(brew --prefix root5_pung)/libexec/set_root5.sh' >> ~/.bash_profile

    Have fun!
    EOS
  end
end
