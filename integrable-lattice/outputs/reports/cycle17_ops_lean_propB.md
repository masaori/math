# cycle 17 step 3（運用 / Lean）: 命題 B の等式を閉じる — 到達範囲と限界

**日付**: 2026-07-31 / **track**: 運用（Lean 形式検証） / **step**: `lean_prop_B_completion`

## 0. 結論（先に）

1. **命題 B は、論文本文のステートメントのままでは偽である。** 記号 $\pi(p,1)$ が
   命題 A の定義（**行列冪列** $T^N\bmod p^k$ の最終周期）と、命題 B の証明が実際に扱う量
   （**トレース列** $Z_N=\operatorname{Tr}T^N\bmod p$ の最終周期）とで**別物**なのに共有されている。
   $4\times4$ の反例を作り、Lean で形式化した。
2. **読みをトレース列に直せば、等式は両方向とも成り立ち、Lean で閉じた。**
   逆方向（本 step の目的）だけでなく、人手証明の第 1 段
   $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$ も形式化できたので、
   代数閉体上では**仮定なしの完成形**まで到達した。
3. **cycle 16 が書いた「残るのは組み立ての作業量であって道具の不在ではない」は、
   前提が誤っていた。** 逆向きが出なかったのは半単純性の組み立てが未実施だからではなく、
   その読み自体が偽だったからである（半単純性を仮定しても、行列冪列の周期についての
   命題 B は成り立たない。反例の行列は半単純である＝対角化可能）。
4. 副産物として、**命題 C（Pisano 型上界）はトレース列の読みでは偽**であることも分かった
   （3.4% の反例）。つまり命題 A・B・C は同じ記号を共有できない。

**新規性は主張しない。** 指標の一次独立（Artin–Dedekind）も線形漸化列の周期も古典であり、
本 step の内容は自分たちのステートメントの訂正と、その Lean 化である。

## 1. 何が起きていたか（一次情報）

| 出典 | $\pi(p,k)$ の定義 |
|---|---|
| `outputs/paper-plans/002_R_Lambda_duality.md` §2 命題 A | 「$T^N\bmod p^k$ の最終周期」＝**行列冪列** |
| `outputs/reports/cycle3_T1_D-U2_rigorous.md` 冒頭 1. | 同上（行列冪列） |
| `structured-latex/content/004_lambda_finite.ts`（命題 B のブロック） | 「命題 A の $\pi(p,1)$ について」と明記 |
| `sagemath/check/cycle3_T3_period/README.md` 冒頭 | 「$Z_N\bmod p^k$ の列の最終周期」＝**トレース列** |
| 同 `pi_p1_refined.sage` の `trace_period_mod_p` | トレース列の周期を返す実装 |

**cycle 8 の検証はトレース列の周期を測っており、命題 B もその量についての主張である。**
本文だけが命題 A の定義（行列冪列）を指してしまっている。

## 2. 反例（Lean で形式化）

$$T=\begin{pmatrix}0&1\\1&1\end{pmatrix}\oplus\begin{pmatrix}0&1\\1&1\end{pmatrix}\in M_4(\mathbb{Z}),
\qquad p=2,\qquad \det T=1\ (\text{よって命題 A の仮定 }p\nmid\det T\text{ を満たす}).$$

- $\chi_T=(x^2-x-1)^2\equiv(x^2+x+1)^2\pmod2$。$x^2+x+1$ は $\mathbb{F}_2$ 上既約なので、
  相異なる固有値は $\overline{\mathbb{F}_2}$ の 1 の原始 3 乗根 $\omega,\omega^2$ の 2 つで、
  **代数的重複度はどちらも $m_\lambda=2$**。よって $p\nmid m_\lambda$ を満たす固有値は無く、
  **命題 B の右辺は $\operatorname{lcm}(\emptyset)=1$**。
- **行列冪列の周期は $3$**（Lean: `orderOf_cexMat : orderOf cexMat = 3`）。
- **トレース列は恒等的に $0$、周期 $1$**（Lean: `trace_cexMat_pow : (cexMat ^ N).trace = 0`）。

右辺 $1$ はトレース列の周期と一致し、行列冪列の周期 $3$ とは一致しない。
なお**この $T$ は半単純**（$\overline{\mathbb{F}_2}$ 上で対角化可能）なので、
cycle 16 が想定していた「半単純性さえ組み立てれば逆向きが出る」という筋では救済できない。

**頻度**（`sagemath/check/cycle3_T3_period/period_reading_counterexample.py` / `.out`、素の Python 3）:
ランダム整数行列（$p\nmid\det$）**2487 例中 563 例（22.6%）**で 2 つの周期が異なる。
不一致は例外的現象ではない。

## 3. Lean で閉じた範囲

ファイル: `lean/IntegrableLattice/PropBTracePeriod.lean`（`PropB.lean` は片方向のまま残し、冒頭に訂正を追記）。

| 定理 | 内容 |
|---|---|
| `eq_zero_of_expSum_pow_eq_zero` | 相異なる $\mu$ について $\sum_\mu d_\mu\mu^m=0$ が全 $m$ で成り立てば $d\equiv0$（**指標の一次独立**。mathlib の Vandermonde 行列式 `Matrix.det_vandermonde_ne_zero_iff` で証明） |
| `expSum_eventually_periodic_iff` | $t$ が $\sum_\mu c_\mu\mu^N$ の（$N_0$ 以降の）周期 $\iff$ $c_\mu\neq0$ なる全 $\mu$ で $\mu^t=1$。**両方向** |
| `expSum_eventually_periodic_iff_lcm_dvd` | 同じことの整除版: 周期 $\iff\operatorname{lcm}\{\operatorname{ord}\mu:c_\mu\neq0\}\mid t$。$(\Leftarrow)$ が `PropB.lean` の片方向、$(\Rightarrow)$ が**本 step で足した逆方向** |
| `isLeast_period_expSum` | 最小の正の周期がちょうど $\operatorname{lcm}$（＝**等式本体**） |
| `trace_pow_restrict_maxGenEigenspace` | 一般化固有空間へ制限した $f^N$ のトレース $=\mu^N\dim V_\mu$ |
| `trace_pow_eq_sum_maxGenEigenspace` | **人手証明の第 1 段** $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$（代数閉体、一般化固有空間分解） |
| `finrank_maxGenEigenspace_eq_rootMultiplicity` | その $m_\lambda$ が $\chi_f$ の根の重複度に一致（mathlib の `LinearMap.finrank_maxGenEigenspace_eq`） |
| `trace_pow_eventually_periodic_iff` | **仮定なしの完成形**: $K$ 代数閉・固有値がすべて非零（＝$p\nmid\det T$ に対応）なら、$t$ がトレース列の周期 $\iff\operatorname{lcm}\{\operatorname{ord}\lambda:m_\lambda\neq0\text{ in }K\}\mid t$ |
| `natCast_ne_zero_iff_not_dvd` | 標数 $p$ では「$m_\lambda\neq0$ in $K$」$\iff$「$p\nmid m_\lambda$」＝人手証明の条件そのもの |
| `orderOf_cexMat` / `trace_cexMat_pow` / `cexMat_period_ne` | 上記の反例 |

### 形式化していない段（正直に）

- **具体行列 $T\bmod p\in M_d(\mathbb{Z}/p)$ から $\overline{\mathbb{F}_p}$ 上の自己準同型への移送（係数拡大）**は
  していない。完成形は $\overline{\mathbb{F}_p}$ 側の主張、反例は $\mathbb{Z}/2$ 側の計算で、
  両者を Lean 内で接続していない（トレースは環準同型で保たれるので数学的には自明な段）。
  したがって「反例の右辺が $1$」は手計算に依り、Lean が示すのは
  $\operatorname{ord}(T\bmod2)=3$ と $\operatorname{Tr}(T^N)\equiv0$ の 2 つである。
  この 2 つだけで「行列冪列の周期 $\neq$ トレース列の周期」は確定する。
- **mathlib の欠落は本 step では 1 件も主張しない。** 当初は
  「$A^N$ の特性多項式の根が $\lambda^N$」に相当する補題が無いと見て仮定で逃げるつもりだったが、
  `LinearMap.trace_eq_sum_trace_restrict'`・`LinearMap.trace_comp_eq_mul_of_commute_of_isNilpotent`・
  `Module.End.iSup_maxGenEigenspace_eq_top`・`LinearMap.finrank_maxGenEigenspace_eq` の組み合わせで
  自前で証明できたので、**欠落と書く必要が無くなった**（cycle 16 の偽陰性事故の教訓に従い、
  「無い」と書く前に組み立てを試した）。

### 実行した検証（一次情報）

| 実行 | ログ | 結果 |
|---|---|---|
| `lake exe cache get` | `lean/logs/cache-get-cycle17.log` | `Completed successfully in 32926 ms!` / `CACHE_EXIT=0` |
| `lake build` | `lean/logs/build-cycle17-propB.log` | `Build completed successfully (8664 jobs).` / `BUILD_EXIT=0` |
| `bash scripts/check-no-sorry.sh` | `lean/logs/check-no-sorry-cycle17.log` | ソース中に `sorry`/`admit` 無し。列挙した **63 個**の定理はいずれも `sorryAx` 非依存（依存公理は `propext` / `Classical.choice` / `Quot.sound` のみ）/ `CHECK_EXIT=0` |
| 反例と頻度 | `sagemath/check/cycle3_T3_period/period_reading_counterexample.out` | 上記 §2・§4 の数値 |

## 4. 副産物: 命題 C はトレース列の読みでは偽

「命題 B をトレース列の読みに直す」なら、隣の命題 C も同じ読みで良いか確かめる必要がある。**駄目である。**
Pisano 型上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$ をトレース列の周期で測ると、
**1669 例中 56 例（3.4%）で破れる**。例:
$$A=\begin{pmatrix}1&1&-1\\2&1&-2\\-2&-1&-1\end{pmatrix},\quad p=2:\quad
\text{トレース周期}\ (\bmod\,2)=1,\ (\bmod\,4)=4,\qquad 4\nmid 2\cdot1 .$$
（$\det A=3$ で $p\nmid\det A$。トレース列は $\bmod2$ が $1,1,1,\dots$、$\bmod4$ が $1,3,3,3,1,3,3,3,\dots$。）
命題 C の証明（$T^{\pi(p,1)}\equiv I+pS$ と置いて $p^{k-1}$ 乗する）は**行列冪列の主張**であり、
その読みでは正しい。

**したがって本文は 2 つの記号を使い分けなければならない。**
以下、行列冪列の最終周期を $\pi(p,k)$、トレース列の最終周期を $\pi_{\mathrm{tr}}(p,k)$ と書く。

- 命題 A: $\min(v_p(Z_N),k)$ の周期は $\pi_{\mathrm{tr}}(p,k)$ を割り、$\pi_{\mathrm{tr}}(p,k)\mid\pi(p,k)$。
  現行の記述（$\pi(p,k)$ を割る）は**そのままで正しい**（整除しか言っていないため）。
- 命題 B: $\pi_{\mathrm{tr}}(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda):p\nmid m_\lambda\}$。**$\pi$ ではない。**
- 命題 C: $\pi(p,k)\mid p^{k-1}\pi(p,1)$。**$\pi_{\mathrm{tr}}$ では偽。**

## 5. 敵対的レビュー（自分の結論を反証しにいった結果）

1. 「$\pi(p,1)$ は本文のどこかでトレース列と定義されているのでは？」
   → 命題 A の定義（`002` §2、`004_lambda_finite.ts`、`cycle3_T1_D-U2_rigorous.md`）はいずれも行列冪列。
   命題 B のブロックは「命題 A の $\pi(p,1)$ について」と明記しており、読みは一意に定まる。**反証できず。**
2. 「反例は退化（非可逆・冪単）で、命題の仮定を外れているのでは？」
   → $\det T=1$ で $p\nmid\det T$ を満たし、$T\bmod2$ は半単純（対角化可能）。**反証できず。**
3. 「反例が 1 個だけの人工物では？」
   → ランダム標本で 22.6%。0 件観察を根拠にしない規律の裏返しとして、頻度を測った。**反証できず。**
4. 「トレース列の読みなら命題 A・C もそのままで良いのでは？」
   → 命題 C は 3.4% で破れる（§4）。**この反証は成功し、§4 として結論に取り込んだ。**
5. 「Lean の反例は `decide` に頼っており信用できないのでは？」
   → `#print axioms` で `sorryAx` 非依存を確認済み。加えて Python で独立に周期を再計算した（§2）。

## 6. 残件

- 係数拡大（$\mathbb{Z}/p\to\overline{\mathbb{F}_p}$）の Lean 移送。これがあれば反例の右辺 $=1$ も Lean 内で閉じる。
- 命題 N・T・W は未着手のまま（本 step では触れていない）。命題 B の等式が閉じたので、
  次に取るなら $p$ 進 Newton 多角形（命題 N）だが、mathlib 欠落調査（cycle 16）のとおり一から作る必要がある。
- $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の閉じた記述は**未解決のまま**。命題 C が使えないので、
  トレース列の周期の上界は別途立てる必要がある。
