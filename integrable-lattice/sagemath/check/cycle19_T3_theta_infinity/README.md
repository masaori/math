# cycle 19 / T3 Pure: 消滅深度が無限大の場合（$\theta=\infty$）の数値検証

対応する証明本体: [`outputs/reports/cycle19_T3_theta_infinity.md`](../../../outputs/reports/cycle19_T3_theta_infinity.md)

前提となる証明本体:
[`cycle18_T3_general_degenerate_tower.md`](../../../outputs/reports/cycle18_T3_general_degenerate_tower.md)（§4.5・§6.2 が本サイクルの出発点。補題 A1–A5、定理 B・C、命題 F・G）、
[`cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)（定理 D1・D2、§7 の型 I/II/III）、
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（式 $(1.1)$）。

対象ラベルの宣言は [overview.md](overview.md)。

## 対象

cycle 18 は消滅深度 $\theta(a,b)=\mathrm{ord}_{x=0}\overline{\Phi_{(a,b)}}$ で退化塔を扱ったが、
$\overline{\Phi_{(a,b)}}\equiv0$（$\theta=\infty$）の場合は「$E$ を $\ell$ で割って取り直す段階的処理が
考えられるが着手していない」（§6.2）として残していた。本検証はその場合を扱う。

中心となる構成は、$\tilde E$ を **1 径数部分群へ制限した 1 変数 Laurent 多項式**

$$R_{(a,b)}=\psi_{(a,b)}(\tilde E)\in\mathbb{Z}[y^{\pm1}],\qquad \psi_{(a,b)}:z\mapsto y^a,\ w\mapsto y^b$$

であり、その内容の $\ell$ 付値 $\lambda(a,b)$ と、内容を割ったあとの消滅位数 $\theta^*(a,b)$（常に有限）である。
$\theta=\infty\iff\lambda\ge1$。

## 手順

```bash
cd integrable-lattice/sagemath/check/cycle19_T3_theta_infinity
sage theta_infinity.sage > theta_infinity.out 2>&1
```

`_defs19.sage` は cycle 18 の `_defs18.sage`（そのさらに土台は cycle 16 の `_defs.sage`：voltage グラフ、
2 段終結式による塔の全域木数、円分体での付値）を `load` したうえで、制限 $\psi_{(a,b)}$、
$(\lambda,\theta^*,m_1)$、例外直線の列挙、二項式割り切り判定を追加する。
**塔の値と点ごとの付値の計算は cycle 16 の実装をそのまま使っており、本サイクルの理論と独立である。**

## Step 一覧

| Step | 内容 |
|---|---|
| A | 定理 S を円分体での独立な付値計算と照合。§2.6 の「代表依存性」の表も出力 |
| B | 命題 2（判定条件、両辺を独立計算）／命題 3（Newton 差体への所属） |
| C | 補題 4（スケール不変性） |
| D | 系 5（同居構造の計数） |
| E | 系 6（例外方向では一般点も $\theta\ge\ell+1$） |
| F | 定理 X（F1: 全点）、$\Sigma_n$（F2）、定理 X′（F3: 塔の値と照合）、命題 7（F4）、命題 9（F5） |
| G | 母集団 566 塔 × 5 素数の全走査による分類。G2 は命題 8 の全組合せ照合 |
| H | 敵対的レビュー H1–H6（H6 が §9.1 の反例） |

## 限界（正直に記す）

- **Step F3（塔の値との照合）の段数には上限がある。** 2 段終結式の次数が $\ell^{2n}$ で増えるため、
  $\ell=3$ で $n\le3$、$\ell=5,7$ で $n\le2$、$\ell=11$ で $n\le1$ に留めた。
  時間上限で打ち切った計算はログ末尾に全件出力される（今回は **0 件**）。
- **Step F1・F2 の全点照合のレベル上限**は $\ell=3$: 3、$\ell=5,7$: 2、$\ell=11$: 1。
  そのレベル以下は**全点**であって標本抽出ではない。
- **Step G の母集団は 566 個**（bouquet 2–5 ループ・voltage 6 種、2 頂点平行 3–5 重辺・voltage 4 種）。
  件数はこの母集団についてのものであって、「全ての塔」についてではない。
  **$\ell=7,11$ で $\theta=\infty$ が 0 件なのはこの母集団の人工物**であり、
  Step G2（$1\le p,q\le12$）では $\ell=13$ でも起きる。
- **Step B・C・H5 の探索箱**は $|a|,|b|\le6$（H5 は $\le12$）。ただし有限性は命題 3（定理）から
  従うのであって、箱の大きさが根拠ではない。
- **証明していないことは検証していない。** $\theta\ge\ell+1$ かつ例外直線なしの塔（cycle 19 step 1 の担当）と、
  一般の塔で例外直線があるときの閉形式は本検証の対象外である（H6 は「素朴な延長が偽であること」だけを示す）。

## 結果

`RESULTS.md` を参照。総 **PASS 44950 / FAIL 0**、打ち切り **0 件**。
