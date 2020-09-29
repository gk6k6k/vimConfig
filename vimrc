execute pathogen#infect()

set laststatus=2               " show status line
set number                     " print line number
"set relativenumber             " use relative number
set listchars=tab:»\ ,trail:·  " map some white chars
set list                       " print white characters
set nowrap                     " don't wrap lines
set cursorline                 " make line in current line
set autoindent                 " use same tab size in new next line
set cino=g0N-s
set complete-=i                " do not search in include files
"set spell                      " use spell check
set expandtab                  " use space instead of tab
set shiftwidth=4
set softtabstop=4
set path+=**                   " Recursive searching path
set hlsearch                   " Highlight all seartch pattern
set smartindent
set cindent
"set autoread
:autocmd BufWritePost * silent !echo "<afile>" >> /home/akrupski/.pipe

syntax on

" Plugins "
nnoremap <silent> <F5> :call My_switch()<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <silent> <F10> :call My_insertInclude()<CR>
nnoremap <silent> <F12> :call My_class()<CR>

" Tabs mavigation
nnoremap <A-Right>   :tabnext<CR>
nnoremap <A-Left>   ::tabprevious<CR>

" Splits navigation
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>

set backupdir=~/.vim/tmp/
set dir=~/.vim/tmp/
set swapfile


function! My_switch()
    let fullFileName = expand('%:t')

    let fileName = split(fullFileName, '\.')[0]
    let fileExte = split(fullFileName, '\.')[1]

    if(fileExte[0] == 'c')
        let command = join(["find ", fileName, ".hpp"], '')
        echo command
        execute command
    endif

    if(fileExte[0] == 'h')
        let command = join(["find ", fileName, ".cpp"], '')
        echo command
        execute command
    endif
endfunction

function! My_class()
    let word = expand("<cword>")
    let command = join(['cat tags | ', 'grep "inherits.*[:,]', word, '\b" | ',"awk '{print $1}' | sed -r '",'s/^.*::(.*)$/\1/',"' | sort -u"], "")
    let a = system(command)
    let aa = split(a)
    let classList = []
    let classListW = []
    let index = 0
    for l:item in aa
        let index = index + 1
        call add(classList, item)
        call add(classListW, join([index, ". ", item], ""))
    endfor
    let selection = inputlist(classListW)
    if(selection == 0)
    else
        execute join([":tag ", classList[selection-1]],"")
    endif
endfunction

function! My_insertInclude()
    :mark h
    let word = expand("<cword>")
    " predefined for std
    let command = join(['cat tags | ', 'grep "^\b', word, '\b" |', "awk '{print $2}' |", 'sed "s/.*[iI]nclude\///" | sort -u'], "")
    let a = system(command)
    "let a = substitute(system(command), '[[:cntrl:]]', '', 'g')
    let aa = split(a)
    let classList = []
    let classListW = []
    let index = 0
    for l:item in aa
        let index = index + 1
        call add(classList, item)
        call add(classListW, join([index, ". ", item], ""))
    endfor
    if(index == 1)
        call append(1, join(["#include \"", classList[0], "\""], ""))
        :'h
    else
        let selection = inputlist(classListW)
        if(selection == 0)
        else
            call append(1, join(["#include \"", classList[selection-1], "\""], ""))
            :'h
        endif
    endif
endfunction

function! My_create()
    let filePath = expand('%:p:h')
    let name = input(join(["New file name: ", filePath]))
    execute (join([":e ", filePath, name], ""))
endfunction

