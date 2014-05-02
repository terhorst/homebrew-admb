require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Admb < Formula
  homepage "http://www.admb-project.org"
  url "http://admb-project.googlecode.com/files/admb-11.1.zip"
  sha1 "d728712cbf9b123e5339b9e77f806c7c49cc3086"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components

  def install
    ENV.deparallelize  # if your formula fails when building in parallel

    ['src/linad99/fvar.hpp', 'src/linad99/ufstream.cpp', 'src/tools99/cifstrem.cpp'].each do |f|
        inreplace f, 'std::_Ios_Openmode', 'std::ios::openmode'
    end

    system "make" # if this fails, try separate make/make install steps
    system "mv build/dist #{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test admb`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end

  def caveats
    "ADMB_HOME is #{prefix}."
  end
end
