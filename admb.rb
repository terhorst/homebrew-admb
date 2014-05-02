require "formula"

class Admb < Formula
  homepage "http://www.admb-project.org"
  url "http://admb-project.googlecode.com/files/admb-11.1.zip"
  sha1 "d728712cbf9b123e5339b9e77f806c7c49cc3086"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel

    ['src/linad99/fvar.hpp', 'src/linad99/ufstream.cpp', 'src/tools99/cifstrem.cpp'].each do |f|
        inreplace f, 'std::_Ios_Openmode', 'std::ios::openmode'
    end

    system "make" # if this fails, try separate make/make install steps
    system "mv build/dist/* #{prefix}"
  end

  def caveats
    "ADMB_HOME is #{prefix}."
  end
end
