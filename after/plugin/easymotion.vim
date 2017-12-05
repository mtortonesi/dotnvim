" Make sure we run these commands only if we actually have easymotion installed
if exists('g:EasyMotion_loaded')
  " s enables 2-char search à la vim-seek
  nmap s <Plug>(easymotion-s2)
  xmap s <Plug>(easymotion-s2)
endif
