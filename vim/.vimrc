" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
" let skip_defaults_vim=1
" 安装插件 curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 安装主题 curl -fLo ~/.vim/colors/sublimemonokai.vim --create-dirs https://raw.githubusercontent.com/erichdongubler/vim-sublime-monokai/master/colors/sublimemonokai.vim
" 安装主题 curl -fLo ~/.vim/colors/monokai.vim --create-dirs https://github.com/sickill/vim-monokai/blob/master/colors/monokai.vim
call plug#begin('~/.vim/autoload')
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'plasticboy/vim-markdown'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'kien/ctrlp.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
call plug#end()

set nocompatible				"去除VI一致性,必须
filetype on

"winpos 5 5          			" 设定窗口位置  
"set lines=40 columns=155    	" 设定窗口大小  

"set splitbelow					" 分割出来的窗口位于当前窗口下边/右边
set splitright
set nolist
set background=dark			  	"配色方案
colorscheme molokai
"colorscheme sublimemonokai
set t_Co=256					"启用256色。

set guioptions-=e				" 使用内置 tab 样式而不是 gui
set guifont=Consolas:h14:cANSI	"windows 设置字体为Monaco，大小14

set encoding=utf-8				"设置文件的代码形式 utf8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
let $LANG = 'en_US.UTF-8'

source $VIMRUNTIME/delmenu.vim	"vim的菜单乱码解决
source $VIMRUNTIME/menu.vim

language messages zh_CN.utf-8	"vim提示信息乱码的解决

filetype plugin indent on 		" 开启插件

set shiftwidth=4 				"设定 << 和 >> 命令移动时的宽度为 4
set tabstop=4					" 设定 tab 长度为 4
set softtabstop=4				" 使得按退格键时可以一次删掉 4 个空格
set bs=2                        "在insert模式下用退格键删除
"set guioptions-=T          	" 隐藏工具栏
"set guioptions-=m          	" 隐藏菜单栏
"set guioptions-=L				" 去除左边的滚动条
"set guioptions-=r				" 去除右边的滚动条
"set guioptions-=b
set showtabline=2 				"设置显示标签栏
"set go=						"不要图形按钮
set helplang=cn					"设置中文帮助
set history=1024				"保留历史记录
set magic 						"设置魔术
set visualbell						"出错时，发出视觉提示
set wildmenu					" vim 自身命令行模式智能补全
set list lcs=tab:\¦\  			" 使用 ¦ 来显示 tab 缩进
set autochdir 					"自动设置当前目录为正在编辑的目录
set wrap 						"设置自动换行
set linebreak 					"整词换行，与自动换行搭配使用
if has("autocmd")   			" 打开时光标放在上次退出时的位置
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu 	" 自动补全菜单
filetype plugin indent on		"允许插件 
set clipboard+=unnamed 			"共享剪贴板  


syntax enable					" 开启语法高亮功能
syntax on						" 允许用指定语法高亮配色方案替换默认方案
set showmatch 					"设置匹配模式，相当于括号匹配
set matchtime=0
set smartindent 				"智能对齐
"set shiftwidth=4 				"换行时，交错使用4个空格
set autoindent   				" 自动缩进
set cindent     				"设置C样式的缩进格式"
set modeline     				" 底部的模式行
set cursorcolumn 				"启用光标列
set cursorline					"启用光标行
set guicursor+=a:blinkon0		"设置光标不闪烁
set fdm=indent 					"更多的缩进表示更高级别的折叠
set laststatus=2				" 总是显示状态栏
set ruler						" 显示光标当前位置	" 打开状态栏标尺
set number						" 开启行号显示

nmap T :tabnew<cr>              " Shift-T 开新 Tab


set noexpandtab					" 不要用空格代替制表符
set whichwrap+=<,>,h,l
set autoread                    "文件在Vim之外修改过，自动重新读入
set mouse=a 					"设置在任何模式下鼠标都可用
set selection=exclusive
set selectmode=mouse,key
set nobackup 					"设置不生成备份文件
set nowritebackup

if has('mouse')					" 鼠标支持
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif

set hlsearch 					"高亮显示查找结果
set incsearch					"增量查找
set gdefault					"行内替换

"显示文件名：总行数，总的字符数
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

set ruler 						"在编辑过程中，在右下角显示光标位置的状态行


filetype plugin on				" 载入文件类型插件
filetype indent on				"为特定文件类型载入相关缩进文件

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

set scrolloff=3					" 光标移动到buffer的顶部和底部时保持3行距离

set foldenable      			" 允许折叠  
set foldmethod=manual   		" 手动折叠 

set foldmethod=syntax           "语法折叠
set foldcolumn=0                " 设置折叠区域的宽度
set foldlevel=100
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set tags=tags 					"设置tags 
let Tlist_Auto_Open=1 			"默认打开Taglist 
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Show_One_File = 1 	"不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Exit_OnlyWindow = 1 	"如果taglist窗口是最后一个窗口，则退出vim 
let Tlist_Use_Right_Window = 1 	"在右侧窗口中显示taglist窗口

set viminfo+=!					" 保存全局变量
set winaltkeys=no				" 设置 alt 键不映射到菜单栏

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"按F5运行python"
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction

"=====================================================
"" NERDTree 配置
"=====================================================
let NERDTreeChDirMode=1
"显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$','\.pyo$', '__pycache__$']
"窗口大小"
let NERDTreeWinSize=40
"按 F2 开启和关闭目录树"
map <F2> :NERDTreeToggle<CR>
