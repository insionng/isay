#encoding:utf-8
require 'rubygems'
require "sinatra/base"
require "sinatra/reloader"
require 'sequel'
require 'erb'

#set :environment, :production
require "./models"
require "./routes"