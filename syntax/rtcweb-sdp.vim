if exists("b:rtcwebSDP_syntax")
  finish
endif
let b:rtcwebSDP_syntax = 1

setlocal foldmethod=syntax

" Basics
" ------
syntax match rtcwebSDPType /^[vostmca]/
highlight link rtcwebSDPType Keyword

syntax match IPv4 /\v((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])(\/(3[0-2]|[1-2]?[0-9]))?/
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}/         " 1:2:3:4:5:6:7:8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}/        " 1:2:3:4:5:6::8 ~ 1::8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}/ " 1:2:3:4:5::8 ~ 1::7:8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}/ " 1:2:3:4::8 ~ 1::6:7:8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}/ " 1:2:3::8 ~ 1::5:6:7:8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}/ " 1:2::8 ~ 1::4:5:6:7:8
syntax match IPv6 /\v[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})/      " 1::8 ~ 1::3:4:5:6:7:8
syntax match IPv6 /\v([0-9a-fA-F]{1,4}:){1,7}:/                        " 1:2:3:4:5:6:7::, 1::
syntax match IPv6 /\v:((:[0-9a-fA-F]{1,4}){1,7}|:)/                    " ::2:3:4:5:6:7:8, ::2:3:4:5:6:7:8,  ::8, ::
syntax match IPv6 /\v::(ffff:)?((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\.){3,3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])/ " ::ffff:127.0.0.1 ::127.0.0.1 (IPv4-mapped address)

highlight link IPv4 Constant
highlight link IPv6 Constant

" Fold m-section
" --------------
syntax region rtcwebSDPMediaSection start=/^m=/ end=/\v(^\n){-}m\=/me=e-2 fold contains=ALL

" Values
syntax match rtcwebSDPNumber /[:= ][0-9]\+[ ;]/ms=s+1,me=e-1
syntax match rtcwebSDPNumber /[:= ][0-9]\+$/ms=s+1
highlight link rtcwebSDPNumber Special

" Attibutional Keywords
" ---------------------
syntax match rtcwebSDPAttrKeyword /\v^a\=(candidate|end-of-candidates):/hs=s+2,me=e-1 contains=rtcwebSDPType
syntax match rtcwebSDPAttrKeyword /\v^a\=(rtpmap|extmap):/hs=s+2,me=e-1 contains=rtcwebSDPType
highlight link rtcwebSDPAttrKeyword Keyword

" Keywords of ICE candidate
" -------------------------
syntax keyword rtcwebSDPCandidateKeyword host srflx prflx relay
highlight link rtcwebSDPCandidateKeyword Statement
