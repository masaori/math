# cycle17 / T3 Pure: 補正項 $\Delta$ が非自明に効く例と、$v_\ell(\kappa(X))$ 寄与の照合

対象の証明本体: [`outputs/reports/cycle17_T3_delta_and_kappa_contributions.md`](../../../outputs/reports/cycle17_T3_delta_and_kappa_contributions.md)

前提となる証明本体:
[`cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)（定理 N1・N2、系 N3、定義 3.1 の $\Delta$）、
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（命題 W ＝ 定理 5、補題 8.2、補題 8.4）

## 対象ラベル

論文 001 の未完了作業 1 の第 2 点（低位項の明示公式）に対応する。本文側のラベルは `paper_remark_D_limits`。
cycle 16 が閉じ切れず `RESULTS.md`「検証できていないこと」の 1・2 として残した**照合の穴**を塞ぐのが本サイクルの目的である。

## 何が穴だったか

cycle 16 の `RESULTS.md` より（原文の要約ではなく、そこに書かれている事実）:

- **(A)** 定理 N2 の補正項 $\Delta$ を計算できた 5 件はすべて $\Delta=0$ だった（いずれも $\ell=3$, $k=2$, $J_0=2$）。
  すなわち **N2 の要である補正項が非自明に効く場面を一度も照合していない。**
  Step 2 が確かめたのは実質的に定理 N1 と同じ形の場合だけだった。
- **(B)** $v_\ell(\kappa(X))>0$ の非退化例が 0 件。3 つの寄与（$\mu$・$k$ の項・$v_\ell(\kappa(X))$）のうち 1 つが未照合。

## ファイル構成

| ファイル | 役割 |
|---|---|
| `delta_examples.sage` → `delta_examples.out` | 主検証。Step 1–6 |
| `search_examples.sage` → `search_examples.out` | `delta_examples.sage` が決め打ちしている例の**出所**（どの族・どの seed の掃引から拾ったか）の再現 |

共有定義は cycle16 の [`_defs.sage`](../cycle16_T3_lower_order/_defs.sage) を `load` する（コピーしない。
実装が分岐すると照合の意味が失われるため）。本ディレクトリで追加した道具は
`eps_profile`（各全次数の係数の $\ell$ 進付値）、`defect_index`（ずれ指数 $\delta$）、
`coeff_vals` / `newton_bound_point`（点ごとの Newton 下限）の 4 つだけである。

## 何を検証したか

数値検証は**証明の代用ではなく、証明した命題の照合**である。本サイクルの命題 A・系 A′ は
report §2 で証明を与えており、ここでの計算はその照合と、cycle16 の定理 N1・N2 の照合である。

| Step | 内容 | 位置づけ |
|---|---|---|
| 1 | 穴 (A)。**$\Delta\neq0$ の非退化例 5 件**を挙げ、$D$ の係数だけから決めた $\Delta$ を使った定理 N2 の予言を、終結式から独立に計算した $\mathrm{ord}_\ell(\kappa_n)$ と照合する。同時に $\Delta=0$ とした定理 N1 の予言が**外れる**ことを見る | 定理 N2 の照合（フィットパラメータ 0 個の out-of-sample） |
| 2 | 命題 A（ずれ指数 $\delta>0$ $\Rightarrow$ $\Delta=0$）と系 A′（$k\le\ell$ $\Rightarrow$ $\Delta=0$）を、$\ell\in\{2,3,5,7,11\}$ の乱択掃引で照合 | 命題 A・系 A′ の照合 |
| 3 | $\Delta$ の内訳。低レベル点ごとに $v_\ell(E)$・補題 8.4 の予言 $k/\varphi(\ell^M)$・Newton 下限を並べ、$\sum(v-k/\varphi)$ が定義 3.1 の $\Delta$ に一致することを確認 | 定義 3.1 の内部整合性と、ずれの機構の同定 |
| 4 | 穴 (B)。**$v_\ell(\kappa(X))>0$ かつ非退化の例 6 件**で塔と照合。$J_0=1$（定理 N1 そのもの）3 件と $J_0\ge2$ 3 件、うち 1 件は $\mu>0$・$v_2(\kappa(X))>0$・$\Delta\neq0$ の**3 寄与同時** | 定理 N1・N2 の照合 |
| 5 | 探索の射程（どの $\ell$・どの $k$・どの族・何件見たか） | 尽くしていない範囲の明示 |
| 6 | **敵対的レビュー**。塔の値を 2 段終結式ではなく Kirchhoff の行列木定理で組み直して独立に再計算し、一致を確認 | 実装依存の排除 |

Step 6 を置いた理由: Step 1・4 の結論は `tower_ords`（2 段終結式）の実装に全面的に依存している。
終結式の実装が誤っていれば「$\Delta$ の照合が合った」という観察に意味が無い。
実際この Step を書いた最初の版で $2n$ のずれが出た（被覆の全域木数の公式
$\kappa_n=\ell^{-2n}\kappa(X)\prod D$ の $\ell^{-2n}$ を二重に引いていた。原因は本スクリプト側の誤りで、
`tower_ords` は正しかった）。修正後は 43 段すべて一致している。

## 手順

```bash
sage delta_examples.sage  > delta_examples.out  2>&1
sage search_examples.sage > search_examples.out 2>&1
```

SageMath 10.6 で実行した。乱数種はスクリプト内で固定してある
（`delta_examples.sage` の掃引は $\ell$ ごとに `20260731 + ell`、`search_examples.sage` は
探索ごとに `20260731` / `20260801`）。

## 計算時間の上限（打ち切りの方針）

$\mathrm{ord}_\ell(\kappa_n)$ の厳密計算は次数 $\ell^{2n}$ の 2 段終結式なので、深い段は現実的な時間で終わらない。
cycle16 の `_defs.sage` の `STAGE_BUDGET`（420 秒/段）をそのまま使い、超えた段は `alarm` で打ち切る。
**打ち切りは実行ログ末尾の「時間上限で打ち切った計算の一覧」に全件出る。**
そこに出た段は未検証であり、結論の射程外である。今回の実行では打ち切りは 0 件だった。

## 結論

実行結果の要約（実測値・破れ件数・打ち切り件数）は [`RESULTS.md`](RESULTS.md) に置く。

## 限界（重要）

- **有限個の例での照合である。** 乱択掃引は網羅ではない。頂点数 $\le3$・辺数 $\le7$・
  voltage $\in[-3,3]^2$ の外は見ていない。$\ell\ge17$ は掃引していない。
- **命題 A の逆は成立しない。** $\delta\le0$ は $\Delta\neq0$ の**必要条件**であって十分条件ではない
  （`delta_examples.out` Step 2 の $\ell=3$ の掃引では $\delta\le0$ の非退化例 8 件のうち
  4 件が $\Delta=0$ だった）。
  したがって「$\Delta\neq0$ になるのはいつか」の完全な判定条件は得られていない。
- **$\Delta$ の値そのものの閉じた式は得られていない。** 定義 3.1 の有限計算で決まることは
  cycle16 で証明済みであり、本サイクルはそれが非自明に効くことを実証しただけである。
- Step 3 の「Newton 下限が一意に達成されるなら $v=$ 下限」は非アルキメデス的評価の一般論から従うが、
  下限が複数箇所で達成される点では $v\ge$ 下限しか言えず、実際の値は個別計算に依っている。
