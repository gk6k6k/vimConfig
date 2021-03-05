set laststatus=2               " show status line
set number                     " print line number
set autoindent                 " use same tab size in new next line
set cino=g0N-s
set expandtab                  " use space instead of tab
set shiftwidth=4
set softtabstop=4
set path+=**                   " Recursive searching path
set smartindent
set cindent
set nowrap
set listchars=tab:»\ ,trail:·  " map some white chars
set list                       " print white characters
set nowrap                     " don't wrap lines
set cursorline                 " make line in current line

highlight Pmenu ctermbg=gray guibg=gray
"highlight CocErrorSign ctermfg=Green  guifg=#a1a1a1

" Tabs mavigation
" old
nnoremap <C-Right>   :tabnext<CR>
nnoremap <C-Left>   ::tabprevious<CR>

nnoremap <C-h>   ::tabprevious<CR>
nnoremap <C-l>   :tabnext<CR>

" Splits navigation
" old
nnoremap <A-Down> <C-W><C-J>
nnoremap <A-Up> <C-W><C-K>
nnoremap <A-Right> <C-W><C-L>
nnoremap <A-Left> <C-W><C-H>

" Splits navigation
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>



"let g:coc_node_path =''
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'preservim/tagbar'
Plug 'rhysd/vim-clang-format'

call plug#end()

nnoremap <F4> :NERDTreeToggle<CR>
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] "Hide files in .gitignore
let g:ctrlp_show_hidden = 1                                                         "Show dotfiles
"let g:tagbar_ctags_bin = ""
"let g:clang_format#command = ""
let g:airline_theme='badwolf'

nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

nnoremap <silent> <F5> :call My_switch()<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <silent> <F10> :call My_insertInclude()<CR>
nnoremap <silent> <F12> :call My_class()<CR>

