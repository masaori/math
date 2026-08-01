# cycle 22 / T3 Pure: 係数 $d,e$ の構造と mod $\ell$ の切れ目 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle22_T3_coefficients_d_e.md`](../../../outputs/reports/cycle22_T3_coefficients_d_e.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_J` | $n\ell^n$ の係数 $b=\sum_{P\in S_\infty}j^*(P)$。本検証の Step F・G・H は、**$b$（と $a$）だけが $\bar{\tilde E}$ から決まり、$c,d,e$ は決まらない**という切れ目を反例で確定させる。命題 J の射程がどこで止まるかを示す |
| `paper_prop_R` | 終結式による点ごとの付値（(R4)）と予言アルゴリズム（(R5)）。本検証の実測 $\Theta_M$ はすべて (R4) の整数終結式で計算しており、Step C・E がその上に載る |

本サイクルの新しい命題（定理 D1–D6、命題 D1a）に対応する論文本文のブロックは
**本 step では作らない**。cycle 22 の step 割り当てにより、
**本文（`structured-latex/` と `structured-latex-en/`）を触ってよいのは step 1 だけ**である。
上表は「既存ブロックのどの主張を本検証が支えるか」を宣言したものである。

> **`verify-check-linkage.ts` の孤立警告について**: 同ツールは
> 「本文ブロックの `verification` フィールドからこのディレクトリを参照しているか」で判定するので、
> 本文を触れない本 step ではこのディレクトリは**孤立として報告される**
> （cycle 21 の `cycle21_T3_general_closed_form/`・`cycle21_T3_b_star/` も同じ状態で残っている）。
> ツール自体は `OK: 参照されている対応はすべて生きている` を返す（既存の参照は壊していない）。
> 参照を張るのは本文を触る step の仕事である。

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 内容 | Step |
|---|---|---|
| 定理 D1 | $d=\sum_{P_0}(\mathcal{T}(P_0)-e_{j^*}\ell^{K})-2$（局所式）と $c$ の局所形。$\Lambda\to c$、$\theta^\sharp\to d$ の分業。$d\in\mathbb{Z}$ | A |
| 命題 D1a | 飽和深度 $K$ を上界として水増ししても $(c,d)$ が変わらない | B |
| 定理 D2 | $e=v_\ell(\kappa(X))-a-c+T_\mathrm{def}$、$T_\mathrm{def}$ の $M^*$ 非依存性 | C, E |
| report §3 注 3.1 | $T_\mathrm{def}$ の分布（$0$ でない塔が実在する） | D, L |
| report §5.2 | 第 2 層 ＋ $v_\ell(\kappa(X))$ まで一致しても $e$ が違う塔の組が実在する | K, K2 |
| 定理 D3 | $\bar{\tilde E}$ も $\mu$ も一致する**実在の voltage グラフ 2 本**で $d,e$ が違う | F |
| 定理 D4 | 任意の $N$ で「mod $2^N$ 一致だが $c$ が違う」対が存在する（手計算との突き合わせ込み） | G |
| 定理 D5 | 任意の $N$ で「mod $2^N$ 一致だが $d$ が違う」対が存在する（$\Lambda_1$ は不変、$\theta^\sharp_1$ だけ動く） | H |
| 定理 D6 | $N>\max_k\Lambda_k$ の摂動では段データも $(c,d)$ も不変 | I |
| report §1 | 5 係数（**$e$ を含む**）と Matrix–Tree 定理の塔の値の照合 | E |

## 検証の設計（自由度 0 の out-of-sample）

- **実測側**: $\Theta_M=\sum_{P}\hat\theta_M(P)$ は cycle 20 定理 L4 の**整数終結式**、
  塔の値 $\mathrm{ord}_\ell(\kappa_n)$ は **Matrix–Tree 定理**。どちらも本サイクルの理論から独立。
- **予言側**: $(a,b,c,d,e)$ は $D$ の係数だけから決まる。**当てはめ（fit）を一切していない。
  自由度 0 である。**
- 定理 D3・D4・D5 の族については、**手計算した $(\Lambda_k,\theta^\sharp_k)$ と機械計算を
  1 対 1 で出力して比較する**（Step G・H）。当てはめでないことの二重の担保である。
- cycle 20 step 3 の検証コード `fit_b` は 4 レベルで 4 パラメータを当てはめており、
  自由度 0 の当てはめを out-of-sample と読み違える危険があった。本検証はその設計を採らない。

## 運用上の設計要件

- **1 本のスクリプトの壁時計上限を 20 分以内に設計する**（cycle 19・20 で 3 回起きた
  「掃引起動直後にセッションが終了」への対策。cycle 21 でこの設計要件にして 0 件になっている）。
  そのため Step E は `structure.sage` から `tower_check.sage` へ分離した。
- **検証は PASS/FAIL だけでなく内訳を吐く**（分布・件数・打ち切りの中身）。
- **打ち切り・設計上の除外は件数と中身を必ず出力する**。
  Step C の $T_\mathrm{def}$ の $M^*$ 非依存性は、$\ell=5,7$ で $\Theta_{M^*+1}$ の実測が重すぎるため
  **設計上 $\ell=2,3$ に限っている**（打ち切りではなく事前の限定。件数を出力する）。

## 先行サイクルとの関係

- cycle 21 step 2（[`cycle21_T3_general_closed_form.md`](../../../outputs/reports/cycle21_T3_general_closed_form.md)、
  検証は [`../cycle21_T3_general_closed_form/`](../cycle21_T3_general_closed_form/)）の
  定理 G1–G4 が本サイクルの出発点である。実装も `_defs21.sage` を load して再利用する。
  **$d$ と $e$ は cycle 21 定理 G4 で既に決まっており、本サイクルはその構造を調べる**
  （report §1 の訂正）。
- cycle 21 §9.1 の反例（$\bar{\tilde E}$ を固定して $\Lambda_1$ が動く）は $\tilde E$ への摂動であり、
  voltage グラフとして実現できるかを述べていなかった。本検証の Step F・G・H は
  **すべて実在の voltage グラフの対**で反例を作っている。
- cycle 20 step 1 の定理 L4（整数終結式）と step 2 の定理 W3・W4 を予言側で使う。

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle22_T3_coefficients_d_e
sage structure.sage        > structure.out        2>&1   # Step A-D
sage mod_ell_cut.sage      > mod_ell_cut.out      2>&1   # Step F-I
sage transient_needed.sage > transient_needed.out 2>&1   # Step K-L
sage tower_check.sage      > tower_check.out      2>&1   # Step E
```

詳細（手順・限界）は [README.md](README.md)、Step ごとの実数値は [RESULTS.md](RESULTS.md)。

## 実行ステータスと結果

（[RESULTS.md](RESULTS.md) に転記する。）
