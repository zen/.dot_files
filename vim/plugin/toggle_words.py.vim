" toggle_words_py.vim
" Author: Łukasz Langa 
" Created:  Mon Feb 01 22:43:12 CET 2010
" Requires: Vim Ver7.0+ 
" Version:  1.0
"
" Documentation: 
"   The purpose of this plugin is very simple, it can toggle words among
"   'true'=>'false', 'True'=>'False', 'if'=>'elseif'=>'else'=>'endif' etc . 
"
"   To use it, move the cursor on some words like 'true', 'False', 'YES', etc, 
"   call command 
"     :ToggleWord
"
"   It will toggle 'true'=>'false', 'False'=>'True', 'YES'=>'NO' etc. Yes,
"   this script will try to take the case into account when toggling words, so
"   'True' will be toggled to 'False' instead of 'false'. If the translation
"   includes upper case letters, the translation case will be preserved.
"
"   This script can search the candicate words to toggle based on
"   current filetype, for example, you can put the following configuration
"   into your .vimrc to define some words for python:
"      let g:toggle_words_dict = {'python': [['if', 'elif', 'else']]}
"   
"   There are some default words for toggling predefined in the
"   script(g:_toogle_words_dict) that will work for all filetypes.
"   Any comment, suggestion, bug report are welcomed. 
"
" History:
"  1.0:
"    - initial version based on Vincent Wang's VimScript plugin 

if exists("g:load_toggle_words")
   finish
endif

if !exists('g:embedded_python_version') || g:embedded_python_version < 230 || g:embedded_python_version > 299
  "echo "This plugin requires Python 2.3+ (not 3.x though)."
  let g:load_toggle_words = "ERROR"
  finish
else
  let g:load_toggle_words = "py1.0"
endif

python << endpython
import os, sys, vim
path = "/plugin/toggle_words.py"
prefix = "~/.vim"
if sys.platform in ('win32',):
  path = path.replace('/', '\\')
  prefix = r"C:\Tools\Vim\vimfiles"
vim.command("pyfile %s%s" % (prefix, path))
endpython

command! ToggleWord :py ToggleWord()

nmap ,t :ToggleWord<CR>
