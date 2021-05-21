#!/bin/bash
dir='downloads/web-orders/';
IFS= read -d '' -n 1 orderString 
while IFS= read -d '' -n 1 -t 1 c
do
    orderString+=$c
done

echo '';

read orderNum;
echo '<head>' > $dir$orderNum.html; 
echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">' >> $dir$orderNum.html;
echo "<title>$orderNum</title>" >> $dir$orderNum.html;
echo '</head>' >> $dir$orderNum.html;
echo "<div> Web Order #$orderNum</div>" >> $dir$orderNum.html;
echo '<ol>' >> $dir$orderNum.html;
for sapNum in ${orderString[@]};do
 echo  "<li><a target='_blank' href='https://praktiker.bg/bg/bg/Stolove/TRAPEZEN-STOL-LILOVI-KROS-2-VENGE/p/$sapNum'>$sapNum</a></li><br>" >> $dir$orderNum.html;

done
echo '</ol>' >> $dir$orderNum.html;

