
curl -L -o latin-modern.zip \
    'https://www.gust.org.pl/projects/e-foundry/latin-modern/download/lm2.004otf.zip';
unzip latin-modern.zip -d fonts;
curl -L -o Bareonbatang.zip \
    --referer 'https://copyright.keris.or.kr/wft/fntDwnldView' \
    -d 'fntGrpId=GFT202301120000000000002&fntFileId=FTF202312080000000000070' \
    'https://copyright.keris.or.kr/cmm/fntDwnldById';
unzip Bareonbatang.zip '*.otf' -d fonts;
