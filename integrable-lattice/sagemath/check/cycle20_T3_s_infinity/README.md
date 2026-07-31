# cycle 20 / T3 Pure: $S_\infty$ の判定手続き（一般の塔）の数値検証

対応する証明本体: [`outputs/reports/cycle20_T3_s_infinity_decision.md`](../../../outputs/reports/cycle20_T3_s_infinity_decision.md)

前提となる証明本体:
[`cycle19_T3_theta_ge_ell_plus_1.md`](../../../outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md)（step 1。定理 J4・J7、系 J10、§7.2）、
[`cycle19_T3_theta_infinity.md`](../../../outputs/reports/cycle19_T3_theta_infinity.md)（step 2。定理 S、命題 2・3、定理 X′）。

対象ラベルの宣言は [overview.md](overview.md)。

## 対象

step 1 §7.2 は「$S_\infty$ の候補集合は有限計算で尽きる（系 J10）が、**各候補で $\theta=\infty$ かを
判定する手続き**は一般の塔について実装・検証していない」と明記して終わっている。
本検証はその穴を埋めた手続き `S∞-DECIDE` と、その帰結（$n\ell^n$ の係数 $b$ の予言）を検証する。

## 手順

```bash
cd integrable-lattice/sagemath/check/cycle20_T3_s_infinity
sage s_infinity.sage > s_infinity.out 2>&1
```

`_defs20.sage` は cycle 19 step 2 の `_defs19.sage`（その土台は cycle 18 の `_defs18.sage`、
さらに cycle 16 の `_defs.sage`：voltage グラフ、Matrix–Tree による塔の全域木数、円分体での付値）を
`load` したうえで、本サイクルの道具を追加する。

## 中心となる実測量（本サイクルの理論から独立）

$$\hat\theta_M(a,b)=\varphi(\ell^M)\,v_\ell\bigl(E(g^a,g^b)\bigr)
=v_\ell\Bigl(\mathrm{Res}_y\bigl(\Psi_{\ell^M}(y),\,R_{(a,b)}(y)\bigr)\Bigr),
\qquad R_{(a,b)}(y)=\sum_{(p,q)}c_{pq}\,y^{(pa+qb)\bmod\ell^M}$$

（$\ell$ は $\mathbb{Q}(\zeta_{\ell^M})/\mathbb{Q}$ で完全分岐なので $v_\mathfrak{p}=v_\ell\circ N$、
$N(R(g))=\mathrm{Res}(\Psi_{\ell^M},R)$、$\hat\theta_M=\varphi(\ell^M)v_\ell=v_\mathfrak{p}$）。

**整数の終結式だけで閉じており、「最小点が一意」のような仮定を一切置かない。**
したがって定理 B′ や定理 J4 の予言と突き合わせる相手として使える
（cycle 19 が円分体の元の演算で出していた量と同じものを、より速く・より広い範囲で出す）。

健全性の確認: 本実装の $\Theta_M$ は、step 1 が独立に記録している値と全一致する
（$\ell=2$ トーラス $\Theta_3=44$、$\ell=3$ 反例 $12,42,142,478,1594,5266$、
$\ell=5$ 反例 $18,106,626,3626$）。

## 母集団

- (a) 1 頂点 bouquet、ループ 2 本・3 本、voltage は $\{(1,0),(0,1),(1,1),(1,-1),(2,1),(1,2)\}$ からの重複あり組合せ
- (b) 2 頂点平行 3 重辺、voltage は $\{(0,0),(1,0),(0,1),(1,1)\}$ からの重複あり組合せ
- (c) 族 $p(1,0)+q(0,1)$、$1\le p\le q\le6$
- (d) 名前つきの塔 6 個（$\ell=2$ トーラス、step 2 §9.1 の 2 つの反例、重複度 2 や $b\ge3$ を作るもの）

素数は $\ell\in\{2,3,5,7,11\}$。

## 限界（宣言する）

- **深い $\Theta_M$ 掃引は全塔ではできない。** 到達レベルは $\ell=2$: $M\le8$、$\ell=3$: $M\le6$、
  $\ell=5$: $M\le4$、$\ell=7$: $M\le3$（$\ell=5$ の $M=5$ は 8 分でも終わらないことを実測で確認した）。
  $\ell=11$ は $M=2$ でも重いので深い掃引をしていない。
- **深い掃引の対象は選択している。** 選択規則は「名前つき塔は全件 + $b$ の値ごとに 3 件、
  上限 14/素数」。落とした塔の件数は実行ログの末尾に全件出る。
- **$\ell=7$ では $b$ の独立抽出（当てはめ）ができない。** 4 パラメータの当てはめに
  レベルが 5 つ必要だが 3 つしか取れない。$\ell=7$ については層ごとの内訳（Step E′）だけが根拠である。
- **out-of-sample の浅いレベルでのずれは FAIL としない。** 定理 J7 は
  $M\ge\max(r_0,L_U,n_1)$ でしか主張しておらず、$L_U$・$n_1$ を有限計算で決めていないためである。
  ずれた最大レベル $M^\dagger$ を出し、それより上が全部当たっているかを見る。
- $d=2$ に限る。

結果は [RESULTS.md](RESULTS.md)、全ログは `s_infinity.out`。
