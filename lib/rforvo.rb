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

module Rforvo
  class Rforvo

    def initialize(api_key, language = 'en')
      @api_key = api_key
      raise ArgumentError, "Forvo API Key needed." if api_key.nil? || api_key.empty?
      @lang = language
    end

    def standard_pronounciation(word)
      return nil if word.nil?
      content = MultiJson.load(open(URI::escape("http://apifree.forvo.com/key/#{@api_key}/format/json/action/standard-pronunciation/word/#{word}")).read)
      if content['items'] && content['items'].count > 0
        content['items'].first['pathmp3']
      else nil end
    end

  end
end
