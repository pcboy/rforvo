# -*- encoding : utf-8 -*-
#
#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                  Version 2, December 2004
#
#  Copyright (C) 2004 Sam Hocevar
#  14 rue de Plaisance, 75014 Paris, France
#  Everyone is permitted to copy and distribute verbatim or modified
#  copies of this license document, and changing it is allowed as long
#  as the name is changed.
#  DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#
#
#  David Hagege <david.hagege@gmail.com>
#

require "rforvo/version"
require 'open-uri'
require 'multi_json'
require 'base64'

module Rforvo
  class Rforvo

    def initialize(language = 'en')
      @lang = language
    end

    def standard_pronunciation(word)
      return nil if word.nil?
      search = "http://forvo.com/search/#{::CGI::escape(word)}/#{@lang}"
      play_url = open(search).read.split.select{|x| x.start_with?('onclick="Play(') }
      return nil if play_url.empty?
      file = Base64.decode64(play_url.first.scan(/Play\(\d+,'([^']+)','([^']+)',false,'([^']+)',/).flatten.last)
      "http://audio.forvo.com/audios/mp3/#{file}" if file
    end

  end
end
