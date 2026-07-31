# cycle16 / T3 Pure: 低位項の係数と退化点の数値検証

対象の証明本体: [`outputs/reports/cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)

前提となる証明本体:
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（定理 5 ＝ 命題 W、補題 8.2、補題 8.4、補題 8.5）

## 対象ラベル

論文 001 の未完了作業 1 の第 2 点（低位項 $\lambda_i,\mu_i,\nu$ の明示公式が無い）と
第 3 点（退化点が $n$ とともに増える $P$ の整理が未了）に対応する。
本文側のラベルは `paper_remark_D_limits`。

## ファイル構成

| ファイル | 役割 |
|---|---|
| `_defs.sage` | 共有定義（voltage グラフ、終結式による $\kappa_n$、円分体での付値）。下の 2 本が `load` する |
| `lower_order.sage` → `lower_order.out` | 主検証。Step 1–7 |
| `degenerate_odd.sage` → `degenerate_odd.out` | $\ell\equiv1\bmod4$ のトーラス（退化塔）に絞った検証。Step A・B |
| `band_structure.sage` → `band_structure.out` | 退化帯の上での付値の $M$ 依存性。**自己完結**（`_defs.sage` を使わない） |

`band_structure.out` だけは他の 2 本より前の実行のログである。
本サイクルで `_defs.sage` の `invariants` を修正した（$\mu>0$ の例が落ちるバグ）が、
`band_structure.sage` は `invariants` を持たず、扱う例も全て $\mu=0$ なので影響を受けない。

## 何を検証したか

数値検証は **証明の代用ではなく、証明した命題の照合**である。
report の定理 N1・N2・D1・D2 はいずれも report 側で証明を与えており、ここでの計算はその照合である。
証明が付いていない箇所（型 II / 型 III の分類、$\ell$ 奇の退化塔の閉形式＝仮説 6.1）は
**数値観察にとどまる**ものとして下に明記する。

### `lower_order.sage` → `lower_order.out`

| Step | 内容 | 位置づけ |
|---|---|---|
| 1 | $J_0=1$（$\iff k\le\ell-2$）での完全閉形式 $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+c(\ell^n-1)-2n+v_\ell(\kappa(X))$、$c=k(\ell+1)/(\ell-1)$ を全段で照合。**フィットパラメータ 0 個** | 定理 N1 の照合 |
| 2 | $J_0\ge2$ での補正 $\Delta$ を、レベル $\ell^{J_0-1}$ 以下の 1 の冪根での有限和だけから決め、**塔の値 $\kappa_n$ を一切使わずに**予言して照合 | 定理 N2 の照合 |
| 3 | $\mu>0$ / $v_\ell(\kappa(X))>0$ の例をランダム探索して同じ 0 パラメータ照合 | 定理 N1・N2 の照合 |
| 4 | 退化帯の計数 $\lvert\mathrm{Band}_n\rvert=z_H(\ell^{2n}-1)/(\ell+1)$、および帯と例外点の一致 | 定理 D1 の照合（4b は注 4.4 の観察） |
| 5 | $\ell=2$ トーラス: 点ごとの付値、$\Sigma_M=(M+1)2^M-4$、閉形式 $\mathrm{ord}_2(\kappa_n)=2n2^n+4\cdot2^n-6n-1$ | 定理 D2 の照合 |
| 6 | 型 I / II / III の分類（5 段フィット＋より小さい $n$ での out-of-sample 検算） | **数値観察のみ**（フィットは証明ではない） |
| 7 | $\ell\equiv1\pmod4$ のトーラス（$\ell=5,13,17$）の退化の様子と仮説 6.1 の閉形式 $(6.3)$ | **数値観察のみ** |

### `degenerate_odd.sage` → `degenerate_odd.out`

report 仮説 6.1（退化帯の上で $v_\ell(E)=4/\varphi(\ell^M)$）を 2 方向から突く。

| Step | 内容 | 位置づけ |
|---|---|---|
| A | 仮説 6.1 由来の閉形式 $(6.3)$ と、終結式から独立に計算した $\mathrm{ord}_\ell(\kappa_n)$ の照合 | **観察**。塔の値に対しては out-of-sample だが、$M$ の範囲については out-of-sample ではない（下記） |
| B | `band_structure.sage` が届かなかった**より大きい $M$** で、帯の上の点を**標本抽出**して $v_\ell(E)\varphi(\ell^M)$ を測る | **観察**。全列挙ではない |

**Step A の射程についての注意（重要）**: トーラスの $\mathrm{ord}_\ell(\kappa_n)$ はレベル $M\le n$ の点にしか
依存しない。よって $n\le3$ での一致が使う帯の付値は $M\le3$ の分だけで、これは `band_structure.out`
Step D で既に測った範囲と同じである。Step A が確かめているのは
**「帯の付値を足し上げると塔の値を再現する」という帳尻**であって、大きい $M$ への外挿ではない。
外挿を突くのが Step B である。

### `band_structure.sage` → `band_structure.out`

**「なぜ $\ell=2$ でだけ $n\ell^n$ 項が出るのか」**を分離するために、
退化帯の上での点ごとの付値の $M=\max(i,j)$ 依存性を直接測る。

| Step | 内容 | 位置づけ |
|---|---|---|
| A | 恒等式 $\zeta+\zeta^{-1}+\xi+\xi^{-1}=g^{-b}(1+g^{b-a})(1+g^{a+b})$ | 定理 D2 の証明の出発点 $(5.2)$ の照合 |
| B | $\ell=2$ トーラスの**非対角**点（$i\neq j$）では $v_2(D)=2^{2-M}=k/\varphi(2^M)$ | 補題 5.3 の照合 |
| C | $\Sigma_n$ の 3 分解（対角 $(M+1)2^M-4$ / 非対角 $2^{M+1}$ / 合計） | 定理 D2 の証明の内訳の照合 |
| D | 退化帯の上での $v_\ell(E)\cdot\varphi(\ell^M)$ の分布を $M$ ごとに出す | 命題 D3 の根拠、および仮説 6.1 の出所 |

## 手順

```bash
sage lower_order.sage    > lower_order.out    2>&1
sage degenerate_odd.sage > degenerate_odd.out 2>&1
sage band_structure.sage > band_structure.out 2>&1
```

SageMath 10.6 で実行した。乱数種は `_defs.sage` の `set_random_seed(20260731)` で固定してある。

## 計算時間の上限（打ち切りの方針）

$\mathrm{ord}_\ell(\kappa_n)$ の厳密計算は次数 $\ell^{2n}$ の 2 段終結式なので、深い段は現実的な時間で終わらない。
そこで **1 段あたりの時間上限**を設け（`_defs.sage` の `STAGE_BUDGET`、`degenerate_odd.sage` Step A は
`STEP_A_BUDGET`）、超えた段は Sage の `alarm` で打ち切る。

- 打ち切った段は `'TO'` として記録し、その例はその段以降を使わずに**使えた段だけ**で照合する。
- 打ち切りは各ログ末尾の **「時間上限で打ち切った計算の一覧」** に全件出る。
  そこに出た段は **未検証** であり、結論の射程外である。
- すなわち **範囲を黙って狭めない**。狭めた場合は必ずログに残る。

## 結論

実行結果の要約（実測値・破れ件数・打ち切り件数）は [`RESULTS.md`](RESULTS.md) に置く。

## 限界（重要）

- **段数が浅い。** 到達できた段数は `RESULTS.md` に実測で記す。
  **$\ell\ge5$ では 5 係数を決めるのに段数が足りない**（5 係数には 5 段必要）。
  これは計算資源の問題ではなく、$\ell^{2n}$ 個の点の積を取るという定義そのものに由来する。
- Step 1–5 と band_structure Step A–C は**証明済み命題の照合**なので段数の浅さは致命的でないが、
  **Step 6・7、degenerate_odd Step A・B、band_structure Step D はフィットないし観察であり、証明ではない。**
  cycle 14 で 4 段フィットが $n=4$ で外れた事故があるため、この区別を厳格に保つ。
- **有限個の例での照合である。** 例は `EX`（15 件）＋ランダム探索であり、網羅ではない。
- `degenerate_odd.sage` Step B は**標本抽出**であって全列挙ではない。
  外れた点が標本に入らなかった可能性は排除できない。
- $\ell$ 奇の退化塔（$\ell\equiv1\bmod4$ のトーラス等）の閉形式は**得られていない**。
  仮説 6.1 は仮説のままである。
