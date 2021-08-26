#!/bin/bash
dir='downloads/web-orders/';
if [[ -n $1 ]];then
	orderString=$1;
	orderString+=' ';

	orderString+=$2;

fi;
echo $orderString;
if [[ -z $orderString ]];then
convert storage/pictures/PhotosEditor/*.jpg storage/pictures/PhotosEditor/pic.pbm;
orderString=$(ocrad --filter=numbers storage/pictures/PhotosEditor/pic.pbm);
# echo 'Въведи сканинг.';
#
# IFS= read -d '' -n 1 orderString
# while IFS= read -d '' -n 1 -t 1 c
# do
#     orderString+=$c
# done
fi;






# Make string of saps to array
i=0;
orderArr=();
for sapNum in ${orderString[@]};do
orderArr[$i]=$sapNum;
((i=i + 1));

done



echo 'Предложения за поръчка.';

#to phone
# mapSearchListManual=$(awk -F'\t' '{gsub(/"/,"",$1); print $1}' web-order-tool/orderPartNumbers.txt );


#to pc
 mapSearchListManual=$(awk -F'\t' '{gsub(/"/,"",$1); print $1}' orderPartNumbers.txt );


itemNumber=1;

for el in ${mapSearchListManual[@]};do
manualArr+=($el);
echo $itemNumber $el;
    ((itemNumber++));
done
echo "Избери номер (1,2,3) или празно.";

read item;

echo ${manualArr[$item - 1]};
echo Допълни номера.;
read numberEnd;
orderNum=${manualArr[$item - 1]}$numberEnd;
echo Записва се поръчка №: $orderNum;


countArticles=0;

#to do:  correct loop


for ((it=0;it< ${#orderArr[@]} ;it+=2));
do
	((countArticles=countArticles + 1));
done


orderNum=$orderNum\($countArticles\);
echo '<head>' > $dir$orderNum.html;
echo '<meta charset="UTF-8">' >> $dir$orderNum.html;
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >> $dir$orderNum.html;
echo '<link rel="stylesheet" type="text/css" href="../style-web/style.css">' >> $dir$orderNum.html;
echo "<title>$orderNum</title>" >> $dir$orderNum.html;
echo '</head>' >> $dir$orderNum.html;
echo "<div> Web Order #$orderNum</div>" >> $dir$orderNum.html;
echo '<ol id="top">' >> $dir$orderNum.html;
iter=1;
	for ((it=0;it< ${#orderArr[@]} ;it+=2));
	do
sapNum=${orderArr[$it]};
quantity=${orderArr[$it +1]};
echo $sapNum;
echo $quantity;
  endUrl=$(curl https://praktiker.bg/search?q=$sapNum | grep $sapNum'" onClick="pushProductClick('$sapNum')">*\<' | cut -f 6 | cut -f 1,2 -d ' ' | cut -f 2 -d '"');

  echo https://praktiker.bg$endUrl;


  name=$(curl https://praktiker.bg$endUrl | grep '<h1>' | sed 's/<h1>//' | sed 's/<\/h1>//');

  ean=$(curl https://praktiker.bg$endUrl | grep '<p class="product-code">EAN' | sed 's/<p class="product-code">//' | cut -f 2 | cut -f 1 -d '<');

rawUrl=$(curl https://praktiker.bg$endUrl | grep '<img src="/medias/sys_master/*/*/*.' | cut -f 1 -d     '.' | cut -f 3 | cut -f 2 -d '"');
imgUrl=https://praktiker.bg$rawUrl.jpg;
# price=$(curl https://praktiker.bg$endUrl | grep -A 2 '<span class="priceValue">' | cut -f 3 | head -n 2 | tail -n 1 | sed 's/<span class="sr">.<\/span><sup>/./' | cut -f 1 -d '<');
price=$(curl https://praktiker.bg$endUrl | grep -A 22 'class="prices' | head -n 22 | sed 's/<table class="prices">/<table style="float:right;" class="prices">/')\</span\>\</p\>\</td\>\</tr\>\</table\>;
	((countArticles=countArticles + 1));
	echo "<li><div id='Div$iter'><a href='https://praktiker.bg/p/$sapNum#globalMessages'>$sapNum</a><p>$name</p><p>$ean $price</p><img src='$imgUrl' width="300" height="300"><p>Поръчани: $quantity бр.</p></div>" >> $dir$orderNum.html;

	echo "<div>
	<button id='toggle' type='button' onclick='divVisibility(\"Div$iter\");'>Скрий / Покажи</button>
	</div></li><hr>" >> $dir$orderNum.html;
((iter=iter + 1));
done

# for sapNum in ${orderString[@]};do
#
#   endUrl=$(curl https://praktiker.bg/search?q=$sapNum | grep $sapNum'" onClick="pushProductClick('$sapNum')">*\<' | cut -f 6 | cut -f 1,2 -d ' ' | cut -f 2 -d '"');
#
#   echo https://praktiker.bg$endUrl;
#
#
#   name=$(curl https://praktiker.bg$endUrl | grep '<h1>' | sed 's/<h1>//' | sed 's/<\/h1>//');
#
#   ean=$(curl https://praktiker.bg$endUrl | grep '<p class="product-code">EAN' | sed 's/<p class="product-code">//' | cut -f 2 | cut -f 1 -d '<');
#
# rawUrl=$(curl https://praktiker.bg$endUrl | grep '<img src="/medias/sys_master/*/*/*.' | cut -f 1 -d     '.' | cut -f 3 | cut -f 2 -d '"');
# imgUrl=https://praktiker.bg$rawUrl.jpg;
# # price=$(curl https://praktiker.bg$endUrl | grep -A 2 '<span class="priceValue">' | cut -f 3 | head -n 2 | tail -n 1 | sed 's/<span class="sr">.<\/span><sup>/./' | cut -f 1 -d '<');
# price=$(curl https://praktiker.bg$endUrl | grep -A 22 'class="prices' | head -n 22 | sed 's/<table class="prices">/<table style="float:right;" class="prices">/')\</span\>\</p\>\</td\>\</tr\>\</table\>;
# 	((countArticles=countArticles + 1));
# 	echo "<li><div id='Div$iter'><a href='https://praktiker.bg/p/$sapNum#globalMessages'>$sapNum</a><p>$name</p><p>$ean $price</p><img src='$imgUrl' width="300" height="300"></div>" >> $dir$orderNum.html;
# 	echo "<div>
# 	<button id='toggle' type='button' onclick='divVisibility(\"Div$iter\");'>Скрий / Покажи</button>
# 	</div></li><hr>" >> $dir$orderNum.html;
# ((iter=iter + 1));
# done

echo '</ol>' >> $dir$orderNum.html;

echo "<script type=\"text/javascript\">
function divVisibility(divId) {
      const targetDiv = document.getElementById(divId);
      // console.log(targetDiv);
      if (targetDiv.style.display !== \"none\") {
        targetDiv.style.display = \"none\";
      } else {
        targetDiv.style.display = \"block\";
      }
      // hideNonVisibleDivs();
    }
</script>" >> $dir$orderNum.html;

# rm storage/pictures/PhotosEditor/*.jpg storage/pictures/PhotosEditor/pic.pbm;
