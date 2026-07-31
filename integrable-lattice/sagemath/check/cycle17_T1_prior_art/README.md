# cycle 17 / T1: 命題 T と Mednykh–Mednykh の定理の整合の厳密確認

スクリプト `tau_v2_exact.py`、出力 `tau_v2_exact.out`（`python3 tau_v2_exact.py`。SageMath 不要。標準 Python の整数のみ）。

本体は `outputs/reports/cycle17_T1_prior_art_check.md`（投稿前の既出性確認）。
**本ディレクトリは定理を証明したものではない。既出文献の主張と本論文の命題 T が両立することを、
厳密整数計算で確かめただけである。**

## 対象（何を検証したか）

対象ラベル: **`paper_prop_T`**（$L\times L$ トーラスの全域木数 $\tau(L)$ の 2 進付値）。

2 つの主張を同時に確かめる。

- **(T)** 本論文の命題 T: 奇数 $L\ge3$ で $v_2(\tau(L))=2(L-1)$。
- **(M)** 既出（Mednykh–Mednykh, *Complexity of the circulant foliation over a graph*,
  arXiv:1902.05681, Theorem 5.1。§7.6 が離散トーラス $T_{n,m}=C_n\times C_m$）:
  奇数 $n$ で $\tau(n)=n\,\tau(H)\,a(n)^2$。$H=C_L$ なら $\tau(H)=L$ なので、$n=L$ 奇に対し
  $\tau(L)=L^2a(L)^2$。したがって **(M) からは $v_2(\tau(L))$ が偶数であることしか出ない**。
  命題 T はこれを $2(L-1)$ に確定させる強化である。

## 手順

$C_L\times C_L$ の Laplacian（$L^2\times L^2$ 整数行列）から 1 行 1 列を落とし、
その行列式を **Bareiss 法（分数を出さない整数消去）** で厳密に計算する（Kirchhoff の matrix-tree 定理）。
$L=3,5,7,9,11,13$。

**浮動小数点を使ってはならない。** 固有値の積を倍精度で計算すると $L\ge7$ で桁落ちし
（$\tau(7)$ は 25 桁）、「命題 T が偽」という誤った結論が出る。本作業中に実際にそれが起きた。

## 結論

| $L$ | $v_2(\tau(L))$ | $2(L-1)$ | $\tau(L)/L^2$ が平方数か |
|---|---|---|---|
| 3 | 4 | 4 | ✅ |
| 5 | 8 | 8 | ✅ |
| 7 | 12 | 12 | ✅ |
| 9 | 16 | 16 | ✅ |
| 11 | 20 | 20 | ✅ |
| 13 | 24 | 24 | ✅ |

(T) と (M) は $L=3,\dots,13$ で両立する。

## 限界

- **有限個の $L$ での確認にすぎない。** 命題 T の証明は本文（`paper_prop_T`）にあり、本計算はその証明の代わりではない。
- (M) が (T) を含意しないことは上に書いたとおりである。**「既出だから命題 T も既出」と読んではならない。**
- $L$ 偶数は対象外（命題 T は奇 $L$ でのみ主張されている）。

## 参照の張り方（呼び出し元へ）

本ディレクトリはまだどのブロックからも参照されていない。`paper_prop_T` のブロックの
`verification` に `sagemath/check/cycle17_T1_prior_art` を追加すれば
`verify-check-linkage.ts` の孤立報告が消える（`structured-latex/` は本 step の担当範囲外なので触っていない）。
