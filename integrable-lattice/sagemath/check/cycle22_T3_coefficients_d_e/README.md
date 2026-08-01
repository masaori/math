# cycle 22 / T3 Pure: 係数 $d,e$ の構造と mod $\ell$ の切れ目 — 手順と限界

対応する証明本体: [`outputs/reports/cycle22_T3_coefficients_d_e.md`](../../../outputs/reports/cycle22_T3_coefficients_d_e.md)。
対象ラベルの宣言は [overview.md](overview.md)、実行結果は [RESULTS.md](RESULTS.md)。

## 何を確かめているか（一言で）

**$d$ と $e$ は cycle 21 定理 G4 で既に決まっている。** 本検証が見るのは値ではなく構造である。

1. $d$ は $S_\infty$ の各点の局所量だけで書け、常に整数である（定理 D1）。
2. $e$ は「過渡欠損 $T_\mathrm{def}$」という $M^*$ 非依存の不変量ひとつで $c$ から書ける（定理 D2）。
3. $c,d,e$ はいずれも $\bar{\tilde E}$（mod $\ell$）では決まらず、
   **$\ell$ 進のどんな固定桁数でも決まらない**（定理 D3・D4・D5）。
   一方、精度が $\max_k\Lambda_k$ を超えれば $c,d$ は決まる（定理 D6）。

## ファイル

| ファイル | 内容 |
|---|---|
| `_defs22.sage` | 共有定義。`_defs21.sage` を load する。局所量 $\mathcal{L},\mathcal{T}$、`d_local` / `c_local`、`transient`、`coeffs5`（5 係数 ＋ $T_\mathrm{def}$）、`recompute_bump`（$K$ 水増し）、`closed_form_D`（生の $D$ から。摂動実験用）、族 `X_t`、`max_Lambda` |
| `structure.sage` | Step A–D。定理 D1・命題 D1a・定理 D2 と $T_\mathrm{def}$ の分布 |
| `mod_ell_cut.sage` | Step F–I。定理 D3・D4・D5・D6 |
| `transient_needed.sage` | Step K–L。第 3 層が余計でないことの探索、$T_\mathrm{def}$ の分布 |
| `tower_check.sage` | Step E。Matrix–Tree の塔の値と 5 係数（$e$ を含む）の照合 |
| `*.out` | 生ログ |

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle22_T3_coefficients_d_e
sage structure.sage        > structure.out        2>&1
sage mod_ell_cut.sage      > mod_ell_cut.out      2>&1
sage transient_needed.sage > transient_needed.out 2>&1
sage tower_check.sage      > tower_check.out      2>&1
```

4 本とも独立に走る（互いの出力に依存しない）。**各本の壁時計上限を 20 分以内に設計してある。**

## 限界（読む人が誤解しないために）

1. **これは証明の代わりではない。** 定理 D1–D6 と命題 D1a はすべて report 本文に
   有限個の例に依らない証明がある。本検証はその照合と、存在主張（反例の実在）の確認である。
2. **定理 D4・D5 の族は $\ell=2$ でしか作っていない。** 奇素数で同型の族があるかは未確認
   （report §11 の 4）。定理 D6（十分条件）の証明は $\ell$ に依らない。
3. **Step G・H は $N\le8$ しか回していない。** 定理 D4・D5 の証明は $N$ に依らない
   （4 箇所の段データをすべて手計算してある。report §6.1・§6.2）ので、
   ここで見ているのは手計算と機械計算の突き合わせである。$N\ge9$ は照合していない。
4. **`closed_form_D`（Step I が使う）は仮定 (H)（全段連結）を確認しない。**
   摂動後の $\tilde E$ は voltage グラフとして実現できるとは限らないので、
   Step I が見ているのは「$\tilde E$ の $\ell$ 進 $N$ 桁目までが段データを決めるか」だけである。
   一方 **Step F・G・H の反例は両側とも実在の voltage グラフ**で、(H) も `closed_form` が確認する。
5. **Step C の $T_\mathrm{def}$ の $M^*$ 非依存性は $\ell=2,3$ に限っている**（設計上の限定。
   $\ell=5,7$ は $\Theta_{M^*+1}$ の実測が 1 塔で数分かかる）。件数は出力される。
6. **$n<n_0$（漸近開始前）のずれは反例ではない。** $M^*$（したがって $n_0$）は十分条件であって
   鋭くない（cycle 21 §9.2）。`tower_check.sage` はその件数を別に数える。
