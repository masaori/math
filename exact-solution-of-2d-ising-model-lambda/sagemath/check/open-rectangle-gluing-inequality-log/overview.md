# SageMath Check: 開境界長方形の接合不等式の対数化（Λ の鎖）

## 対象

**対象ラベル**: `claim_open_rectangle_gluing_inequality_log`

- 実行日: 2026-08-16
- 状態: PASS（形 $(a,b,c)$ 10 通り × 正の有理点 9 点 × 二つの座標の向き、1700 検査。所要 10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda$ で閉じており、実数体も実対数も現れない）。

## 検査内容

証明の段ごとに検査する（第一の座標の向き。第二の座標の向きは $b\to a$、$Z^{\mathrm{op}}_{c,b}\to Z^{\mathrm{op}}_{a,c}$、
$Z^{\mathrm{op}}_{a+c,b}\to Z^{\mathrm{op}}_{a,b+c}$ と置き換えた同じ段）。

- **準備の第一**: $Z^{\mathrm{op}}_{a,b}(q),Z^{\mathrm{op}}_{c,b}(q),Z^{\mathrm{op}}_{a+c,b}(q)\in\mathbb{Q}_{>0}$
  （$\mathbb{Z}[x]$ の開境界分配多項式への代入と配位和の一致も見る）、両端の値 $q^bZ^{\mathrm{op}}_{a,b}(q)Z^{\mathrm{op}}_{c,b}(q)$、
  $Z^{\mathrm{op}}_{a,b}(q)Z^{\mathrm{op}}_{c,b}(q)$ が $\mathbb{Q}_{>0}$ の元であること。
- **準備の第二（前半）** 三段: `claim_log_additive`・`claim_log_power`（$k:=b$）・`claim_log_additive` を
  $\Lambda$ の有限台辞書の等号で。**後半** 一段: `claim_log_additive`。
- **本体** $0<q\le1$: $b\log q+\log Z^{\mathrm{op}}_{a,b}(q)+\log Z^{\mathrm{op}}_{c,b}(q)=\log(\text{下端の値})\le_\Lambda\log Z^{\mathrm{op}}_{a+c,b}(q)\le_\Lambda\log(\text{上端の値})=\log Z^{\mathrm{op}}_{a,b}(q)+\log Z^{\mathrm{op}}_{c,b}(q)$。
  $1\le q$: 向きを反転した同じ鎖。$q=1$ は両場合に属し両方を見る。
  $\le_\Lambda$ は $\mathrm{rat}_\Lambda$ を通した $\mathbb{Q}$ の比較（`def_log_order_group_order`）で判定し、
  `claim_rational_log_order_iff` の移送（`claim_open_rectangle_gluing_inequality_rational` の $\mathbb{Q}$ の比較と一致すること）も各段で見る。

形は接いだ側の一辺が 4 以上にならないもの（$(a,b,c)\in\{(1,1,1),(1,1,2),(1,2,1),(2,1,1),(1,2,2),(2,2,1),(1,3,1),(2,1,2),(1,3,2),(2,3,1)\}$）に限る
（$4\times4$ の配位和は 10 分を超える）。有理点は $\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $a,b,c,q$ についての主張の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/OpenRectangleGluingInequalityLog.lean`（`logOrderLE_openRectangleGlueFirstLog_bounds_of_le_one` 等 4 本と準備の等式 2 本）、
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」の `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、
導出版 `OpenRectangleGluingInequalityLogFromNecSuf.lean`（2026-08-16。lake build・sorry 検査 1237 件 OK）。

## 実行方法

```sh
sage sagemath/check/open-rectangle-gluing-inequality-log/check.sage
```
