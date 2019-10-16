augroup Typo3TcaFileType
    au! BufNewFile,BufRead */Configuration/TCA/*.php set ft=php.typo3-tca
augroup end

augroup Typo3TyposcriptFileType
    au! BufNewFile,BufRead */TypoScript/*.txt set ft=typoscript
    au! BufNewFile,BufRead */TypoScript/*.ts set ft=typoscript
augroup end

augroup Typo3TsconfigFileType
    au! BufNewFile,BufRead */Tsconfig/*.txt set ft=typoscript
augroup end
