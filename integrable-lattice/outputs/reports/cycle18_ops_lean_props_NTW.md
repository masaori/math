# cycle 18 step 3（運用 / Lean）: 確定済み命題 N・T・W を Lean に通して主張を検算する

**日付**: 2026-07-31 / **track**: 運用（Lean 形式検証） / **step**: `lean_props_N_T_W`

## 0. 結論（先に）

1. **命題 N の本文に誤りが 1 件あった。** 「Skolem–Mahler–Lech 型の相殺により、**有限個の $N$ で**
   例外が生じうる」は誤りで、**例外集合は算術級数の有限和であり一般に無限**である。
   $T=\begin{pmatrix}0&1\\2&0\end{pmatrix}$、$p=2$ で**すべての奇数 $N$** が例外になる反例を Lean で形式化した。
   根拠 report（`cycle3_T1_D-U2_rigorous.md`）は「算術級数の有限和」と正しく書いており、
   **本文へ移す段で取り違えていた**。
2. **命題 W の本文に書き落としが 1 件あった。** 閉形式の $\nu$ の帰属（$\mathbb{Z}$ か $\mathbb{Q}$ か）が
   書かれていない。$\frac{k(\ell+1)}{\ell-1}$ は一般に整数ではなく（$\ell=5,k=3$ で $9/2$）、
   $\operatorname{ord}_\ell(\kappa_n)\in\mathbb{Z}$ だから**そのとき $\nu$ は整数ではありえない**。
   この $(\ell,k)$ が非退化性と両立することも `decide` で確認した。
3. **命題 N の本文から、根拠 report にあった不等式 $v_p(Z_N)\ge\mu_{\min}N$ が落ちていた。**
   これは命題 N の唯一の「各 $N$ で成り立つ」形であり、**係数だけから Cayley–Hamilton で出る**
   （固有値も Newton 多角形も $\mathbb{Q}_p$ も要らない）。定数オフセット付きの形を Lean で閉じた。
4. **命題 N の「Newton 多角形の最小傾き」は規約依存**で、本文は規約を書いていなかった。
   下方凸包の取り方によって傾きは根の付値の符号違いになる。規約を本文に明記した。
5. **命題 T には食い違いが見つからなかった。** 本文の数値（奇 $L$ の $2(L-1)$、偶 $L$ の
   $5,19,29,61,53,83,77$）を**独立に再計算して全一致**。証明の代数的な段・奇数性が効く 2 箇所・
   Newton 多角形の組合せ核・総和の段を Lean で閉じた。matrix-tree の段と Hensel の段は閉じていない（§4）。
6. ビルド **8667 jobs 成功**、`check-no-sorry.sh` で列挙した **85 個の定理が `sorryAx` 非依存**
   （cycle 17 は 63 個）。

**新規性は主張しない。** Cayley–Hamilton から線形漸化式を出す議論も Newton 多角形も古典である。
本 step の内容は自分たちのステートメントの検算と訂正、およびその Lean 化である。

## 1. 記号の取り違えに関する注意（cycle 17 の教訓の続き）

cycle 17 は「同じ記号 $\pi(p,1)$ が 2 つの量に使われていた」ことで命題 B が偽だと判明した。
本 step でも**同種の危険**を 1 件見つけた（今回は誤りではなく、参照の紛らわしさである）。

* 根拠 report `outputs/reports/cycle3_T1_D-U2_rigorous.md` の**「命題 B」節は、本文の「命題 N」**である
  （Newton 多角形の節）。本文の命題 B（$\pi_{\mathrm{tr}}(p,1)$ の精密公式）とは別物である。
* `lean/README.md` の対応表は `PropB.lean` の根拠 report として同じファイルを挙げているため、
  ファイル名だけを見ると 2 つの「命題 B」が混ざる。`PropN.lean` の冒頭にこの注意を書いた。

## 2. 形式化した主張

ファイル: `lean/IntegrableLattice/PropN.lean`、`PropT.lean`、`PropW.lean`。

### 2.1 命題 N（`PropN.lean`）

| 定理 | 内容 |
|---|---|
| `trace_pow_add_eq_neg_sum` | Cayley–Hamilton から出るトレース列の線形漸化式 $Z_{d+k}=-\sum_{i<d}c_iZ_{i+k}$ |
| `trace_pow_dvd_of_charpoly_coeff_dvd` | **本体**: $p^{m(d-i)}\mid c_i$（$i<d$）なら $\forall N,\ p^{mN}\mid p^{md}Z_N$ |
| `le_padicValInt_trace_pow` | 同じことを付値で: $mN\le md+v_p(Z_N)$（$Z_N\neq0$） |
| `cexN` / `cexN_sq` / `cexN_pow_add_two` | 反例 $T=\begin{pmatrix}0&1\\2&0\end{pmatrix}$ と $T^2=2I$ |
| `trace_cexN_pow_odd` | **$N$ 奇なら $Z_N=0$**（例外） |
| `trace_cexN_pow_even` | $N=2k$ なら $Z_N=2^{k+1}$（$v_2=N/2+1$、成長率は $\mu_{\min}=1/2$ に一致） |
| `cexN_exceptional_unbounded` | **例外集合は非有界**（したがって無限）＝本文の「有限個の $N$」への反証 |

仮定「$p^{m(d-i)}\mid c_i$」は「Newton 多角形の傾きがすべて $m$ 以上」を**係数の有限チェックで書いたもの**で、
命題 N が主張する決定可能性そのものである。証明は Cayley–Hamilton だけを使い、
**固有値の構成も $\mathbb{Q}_p$ も Newton 多角形の理論も使っていない**。

### 2.2 命題 T（`PropT.lean`）

| 定理 | 内容 |
|---|---|
| `prod_sub_pow_eq` | $\zeta$ が 1 の原始 $L$ 乗根なら $\prod_{k<L}(r-\zeta^k)=r^L-1$ |
| `prod_A_sub_zeta_eq` | **人手証明 (3.1)**: $A=r+r^{-1}$ のとき $\prod_{k<L}(A-\zeta^k-\zeta^{-k})=r^L+r^{-L}-2$ |
| `not_dvd_two_mul_of_odd` | 奇数性が効く箇所その 1: $L$ 奇・$L\nmid j$ なら $L\nmid 2j$ |
| `padicValNat_two_eq_zero_of_odd` | 奇数性が効く箇所その 2: $L$ 奇なら $v_2(L)=0$ |
| `newton_two_root_valuations` | 段 4 の組合せ核: 2 根の付値の和が $1$、和の付値が $0$ なら付値は $0$ と $1$ |
| `v2_tau_eq_of_root_valuations` | 段 5 の総和: 各 $j$ で $v(D_j)=2$ なら $v_2(\tau(L))=2(L-1)$ |

`v2_tau_eq_of_root_valuations` は、matrix-tree 由来の積公式と Hensel 由来の各点付値を
**仮定として型に出した**形になっている。何が外部依存かが機械的に読める。

### 2.3 命題 W（`PropW.lean`）

| 定理 | 内容 |
|---|---|
| `NoProjZero` | 非退化性（$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない）の定義と `Decidable` インスタンス |
| `torus_nondegenerate_three` | 本文の適用例: $\ell=3$、$H=-(T^2+S^2)$ は**非退化**（`decide`） |
| `torus_degenerate_two` | 本文の適用例: $\ell=2$、$H=(T+S)^2$ は**退化**（`decide`）。本文の「射程外」と一致 |
| `exists_proj_zero_of_linear` | 1 次形式は必ず射影零点をもつ ⟹ **非退化なら $k\ge2$** |
| `quintic_cubic_nondegenerate` | $\ell=5$ で 3 次の非退化形式 $t^3+ts^2+s^3$ が実在（`decide`） |
| `propW_nu_not_integer_of_ell_five_k_three` | $\ell=5,k=3$ では $\mu,\nu\in\mathbb{Z}$ と読むと矛盾（$9\cdot5^n$ が偶数になる） |

## 3. 見つかった食い違い（本 step の主成果）

| # | 命題 | 本文の記述 | 実際 | 根拠 |
|---|---|---|---|---|
| 1 | N | 例外は「有限個の $N$」 | **算術級数の有限和＝一般に無限**。$T=(0\,1;2\,0)$, $p=2$ で全奇数 $N$ が例外 | Lean `trace_cexN_pow_odd` / `cexN_exceptional_unbounded`、Python 再計算 |
| 2 | N | 下界 $v_p(Z_N)\ge\mu_{\min}N$ の記載なし（根拠 report にはある） | 各 $N$ で成り立つ形として本文に必要。係数条件だけから出る | Lean `trace_pow_dvd_of_charpoly_coeff_dvd` |
| 3 | N | 「Newton 多角形の**最小傾き**」（規約の記載なし） | 下方凸包の向きで符号が反転する。規約なしでは一意に読めない | 形式化しようとして向きが決まらないことで判明 |
| 4 | W | $\nu$ の帰属の記載なし | $\frac{k(\ell+1)}{\ell-1}$ は一般に非整数。$\ell=5,k=3$ なら $\nu\notin\mathbb{Z}$ | Lean `propW_nu_not_integer_of_ell_five_k_three` / `quintic_cubic_nondegenerate` |
| 5 | W | $k$ の下限の記載なし | 非退化なら $k\ge2$ | Lean `exists_proj_zero_of_linear` |
| 6 | T | — | **食い違いなし**（数値も独立再現） | §5 |

いずれも本文（`structured-latex/content/004_lambda_finite.ts`、`006_propositions_TVW.ts`）へ反映した。

**#4 について誇張しない**: 「$k=3,\ell=5$ が非退化性と両立する」ことは示したが、
**そういう $H$ を最低次部分にもつグラフ塔が実在する**ことは示していない
（$H$ は $\det L$ の最低次斉次部分という追加の制約を受ける）。本文の仮定の書き方の問題として指摘した。

## 4. 形式化できなかった段と、その障害（一次情報）

`scripts/mathlib-gap-survey.sh` を本 step で拡張して再実行した。生ログ `logs/mathlib-gap-survey-cycle18.log`
（走査 8264 ファイル、mathlib commit `520045ab14e2` / v4.32.1）。判定は 3 段（連結語の内容 grep /
語幹の case-insensitive 内容 grep / 語幹の case-insensitive ファイル名検索）で、(2)(3) がともに 0 のときだけ「無い」と書く。

| 段 | 概念 | (1) | (2) | (3) | 判定 |
|---|---|---|---|---|---|
| N 上界方向 | Skolem–Mahler–Lech | `SkolemMahlerLech` 0 | `mahler` 5 | 3 | **無い**。ヒットは Mahler 測度（`Analysis/Polynomial/MahlerMeasure.lean`、`NumberTheory/MahlerMeasure.lean`）と Mahler 基底（`Padics/MahlerBasis.lean`）で、零点集合の定理ではない（中身を確認） |
| N 上界方向 | Strassmann の定理 | `Strassmann` 0 | `strassmann` 0 | 0 | **無い** |
| N 鋭い下界 | companion 行列 | `Matrix.companion` 0 | `companion matrix` 0 | 0 | **無い** |
| N 鋭い下界 | Newton 恒等式 | `MvPolynomial.psum` **2** | `newton identit` 0 | 0 | **在る**（`MvPolynomial/Symmetric/NewtonIdentities.lean` の `psum_eq_mul_esymm_sub_sum`）。(2)(3) が 0 なのは原文が `Newton's Identities`（アポストロフィ入り）だからで、**これは検索語の作り方による偽陰性**（§7-2）。**無いのは行列のトレース冪との接続**であって道具ではない |
| N Newton 多角形 | $p$ 進 Newton 多角形 | `NewtonPolygon` 0 | `newton` 7 | 2 | **無い**。7 件は Newton–Raphson（`Dynamics/Newton.lean`、`Padics/Hensel.lean`、`RingTheory/Henselian.lean`、`JordanChevalley.lean`）と Newton 恒等式 |
| T 段 1 / W | Kirchhoff の matrix-tree | `matrixTree` 0 | `kirchhoff` **0** | **0** | **無い** |
| T 段 1 / W | 全域木数 | `numSpanningTrees` 0 | `spanning tree` 3 | 0 | **数える定理は無い**（3 件は全域木の存在と arborescence） |
| T 段 3 | Hensel の補題 | — | — | — | **在る**（`NumberTheory/Padics/Hensel.lean`）。**無いのは $\mathbb{Q}(\zeta_L)$ の完備化への配線**であって道具ではない |
| W | 岩澤不変量の漸近 | `IwasawaInvariant` 0 | `iwasawa` 6 | 1 | **無い**（群論の岩澤単純性判定法と docstring の言及のみ。cycle 16 の確認と一致） |

**「無い」と書いたのは 5 件、「道具は在るが配線が無い」と書いたのは 2 件**である。
後者を「無い」と書かないのは cycle 16 の偽陰性事故の教訓に従っている。

## 5. 独立の数値検証（Lean の外）

`/tmp` で素の Python 3（SageMath 不要）により、本文の数値を**ゼロから再計算**した。

* $\tau(L)$（$C_L\times C_L$ の全域木数）を、$L^2-1$ 次の縮約ラプラシアンの整数行列式（Bareiss 法、分数なし）
  として計算。**奇 $L=3,5,7,9,11,13,15$ で $v_2(\tau(L))=2(L-1)$ が全一致**。
  **偶 $L=2,\dots,14$ で $v_2=5,19,29,61,53,83,77$**（本文の記載と完全一致）。
* 命題 W の適用例 $\operatorname{ord}_3(\tau(3^n))=4\cdot3^n-2n-4$ を $n=0,1,2$ で確認（$0,6,28$）。
* 命題 N の反例 $\operatorname{Tr}(T^N)$（$T=(0\,1;2\,0)$）が $N=1..10$ で $0,4,0,8,0,16,0,32,0,64$。

## 6. 実行した検証（一次情報）

| 実行 | ログ | 結果 |
|---|---|---|
| `lake exe cache get` | `lean/logs/cache-get-cycle18.log` | `CACHE_EXIT=0` |
| `lake build` | `lean/logs/build-cycle18-NTW.log` | `Build completed successfully (8667 jobs).` / `BUILD_EXIT=0` |
| `bash scripts/check-no-sorry.sh` | `lean/logs/check-no-sorry-cycle18.log` | ソース中に `sorry`/`admit` 無し。列挙した **85 個**の定理はいずれも `sorryAx` 非依存（依存公理は `propext` / `Classical.choice` / `Quot.sound` のみ）/ `CHECK_EXIT=0` |
| `bash scripts/mathlib-gap-survey.sh` | `lean/logs/mathlib-gap-survey-cycle18.log` | §4 の表 / `SURVEY_EXIT=0` |
| `npm run check`（構造化 LaTeX） | — | 生成物の鮮度・型検査・実行時検証・負テスト・ノート非混入まで通過（終了コード 0、32 ブロック / 26 ラベル / 27 参照すべて解決） |

## 7. 自分の誤り（隠さず書く）

1. **設計の誤り（途中で訂正）**: 当初は「命題 N の下界には行列トレース版の Newton 恒等式が要る、
   mathlib には無いから自前で作る」と考えていた。しかし**命題 N が主張しているのは成長率であって
   各 $N$ の鋭い不等式ではない**ので、定数オフセットを許せば Cayley–Hamilton だけで足りる。
   「道具が足りない」と書く前に、必要な主張の強さを見直すべきだった。
2. **偽陰性を自分で作りかけた**: gap survey に足した検索語 `newton identit` が
   mathlib の `Newton's Identities`（アポストロフィ入り）に当たらず 0 件になり、
   危うく「Newton 恒等式は mathlib に無い」と書くところだった。
   **NewtonIdentities.lean は実在する。** cycle 16 の教訓（連結語 grep の 0 件を根拠にしない）が
   そのまま再発しかけた形なので記録する。表記は「在る。無いのは接続」に直した。
3. **`check-no-sorry.sh` の targets に足したおかげで、`PropT.lean` を
   ルートモジュール `IntegrableLattice.lean` へ import し忘れていたことが発覚した**
   （`lake build` は個別ターゲットとして通っていたので気づかなかった）。
   スクリプトが `Unknown constant` で落ちて発覚した。import を追加して解消済み。

## 8. 残件

* 命題 N の**上界方向**（成長率が $\mu_{\min}$ を超えないこと）は未形式化。SML / Strassmann が
  mathlib に無く（§4）、一から作る必要がある。
* 命題 N の**鋭い下界**（オフセット無しの $v_p(Z_N)\ge\mu_{\min}N$）は、Newton 恒等式を
  行列のトレース冪へ接続すれば出る。接続の道具（companion 行列）は無いので、
  `MvPolynomial` 版から根の多重集合経由で組み立てることになる。
* 命題 N の **Newton 多角形と固有値の接続**（最小傾き $=\min_i v_p(\lambda_i)$）は未形式化。
  代数閉体上の付値（$\overline{\mathbb{Q}_p}$）が要る。
* 命題 T の matrix-tree の段と Hensel の段、命題 W の閉形式本体は未形式化（§4）。
* 命題 W の $\nu$ の**値**は本文でも未確定のまま（帰属を $\mathbb{Q}$ と明記しただけである）。
