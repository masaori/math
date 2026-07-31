# cycle 21 / T3 Pure: 一般の塔の閉形式（5 係数すべて）の数値検証 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle21_T3_general_closed_form.md`](../../../outputs/reports/cycle21_T3_general_closed_form.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_J` | $n\ell^n$ の係数 $b=\sum_{P\in S_\infty}j^*(P)$（命題 J の系）。本検証の Step F が、**仮定 (B\*) なしに**これが成り立つことを支える |
| `paper_prop_R` | 終結式による点ごとの付値（(R4)）と予言アルゴリズム（(R5)）。本検証の実測側 $\Theta_M$ はすべて (R4) の整数終結式で計算しており、Step B・E がその上に載る |

本サイクルの新しい命題（定理 G1–G4、系 G5・G6）に対応する論文本文のブロックは
**本 step では作らない**（cycle 21 の step 割り当てにより、本文への反映は step 4 が一括で行う）。
上表は「既存ブロックのどの主張を本検証が支えるか」を宣言したものである。

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 定理 G1 | $\Theta_M=\alpha M\ell^M+\beta\ell^M+\gamma$ から $(a,b,c,d,e)$ への変換 | A, G |
| 定理 G2 | 捻り段データ $(\Lambda_k,\theta^\sharp_k)$ による深さ $k$ の層の $\hat\theta_M$ | E |
| 定理 G3 | 飽和深度の明示上界 $K=\max\{k: j^*\ell\ge(\ell-1)\ell^k\}$ | C, D |
| 定理 G4 | $(\alpha,\beta,\gamma)$ の閉じた式（主結果） | A, B, G |
| 系 G5 | $b=\sum j^*$ が (B\*) なしに成り立つ | F |
| 系 G6 | $S_\infty=\emptyset$ の場合（cycle 19 定理 J6 の $e$ を埋めた形） | A2, B |
| report §6.3 | $\ell=2$ トーラスの $5,19,61,167,417,987$ の再現 | A3 |
| report §6.4 | 飽和は $\ell=2$ 固有ではない（$\ell=3$、$j^*=2=\ell-1$ の反例） | A, C, D |
| report §9.1 | $(\Lambda_k,\theta^\sharp_k)$ は $\bar{\tilde E}$ だけでは決まらない（反例） | D |

## 検証の設計（自由度 0 の out-of-sample）

- **実測側** $\Theta_M=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^M)}\hat\theta_M(P)$ は
  cycle 20 定理 L4 の**整数終結式**で計算する。仮定を一切置かないので、本サイクルの理論から独立である。
- **予言側** $(\alpha,\beta,\gamma)$ は $D$ の係数だけから決まる。**当てはめ（fit）を一切していない。**
  したがって照合は自由度 0 であり、$M$ を増やすたびに新しい out-of-sample 点が増える。
- cycle 20 の検証コード `fit_b` は 4 レベルで 4 パラメータを当てはめており、
  自由度 0 の当てはめを out-of-sample と読み違える危険があった。本検証はその設計を採らない。

## 先行サイクルとの関係

- cycle 20 step 1（[`cycle20_T3_cancellation_recursion.md`](../../../outputs/reports/cycle20_T3_cancellation_recursion.md)、
  検証は [`../cycle20_T3_cancellation/`](../cycle20_T3_cancellation/)）の定理 L4 が実測の土台である。
- cycle 20 step 2（[`cycle20_T3_s_infinity_decision.md`](../../../outputs/reports/cycle20_T3_s_infinity_decision.md)、
  検証は [`../cycle20_T3_s_infinity/`](../cycle20_T3_s_infinity/)）の定理 W3（$S_\infty$ の判定手続き）と
  定理 W4（$j^*$＝二項式因子の重複度）を予言側で使う。実装も `_defs20.sage` を load して再利用する。
- cycle 20 step 3（[`cycle20_T3_ell_equals_2.md`](../../../outputs/reports/cycle20_T3_ell_equals_2.md)）の
  §9.1 が残した「一般の $\ell=2$ 塔の $c,d,e$」が本サイクルの対象である。
  同 report の定理 Y′ の不変量 $w$ は、本 report の $\Lambda_1$ の族における具体形にあたる。

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle21_T3_general_closed_form
sage general_closed_form.sage > general_closed_form.out 2>&1   # Step A-F
sage tower_values.sage        > tower_values.out        2>&1   # Step G
```

詳細（手順・限界）は [README.md](README.md)、Step ごとの実数値は [RESULTS.md](RESULTS.md)。

## 実行ステータスと結果

（[RESULTS.md](RESULTS.md) に転記する。）
