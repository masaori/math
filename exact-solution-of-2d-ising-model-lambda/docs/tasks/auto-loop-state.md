# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 348 は、台帳の先頭行「基準辺の平方以上の辺の密度と基準辺の密度の一様な差の評価（$0<q\le1$）」を上端と下端の二行へ割り、その上端「基準辺の平方以上の辺の密度の基準辺の密度による一様な上からの評価」（$a\ge1$、$a<L$、$a^2\le L$、$0<q\le1$ で $\Psi^{\mathrm{op}}_L\le\frac2a\iota(\ell_2)+\frac4a\iota(\log(1+q))+\Psi^{\mathrm{op}}_a$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_large_side_density_upper_vs_base_side_le_one`（`claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 4 つ（自然数の除法 $L-1=ka+r$、$0\le r<a$ から $k\ge1$・$ka<L\le ka+a$（$L$ が $a$ の倍数かどうかで場合分けしない。$L-1$ を割るので常に $ka<L$）／$\mathbb Q$ の係数比較 $\frac{2a}L\le\frac{2a}{a^2}=\frac2a$・$\frac{4a}L\le\frac4a$（$a^2\le L$）／符号 $0\le\iota(\ell_2)$・$0\le\iota(\log(1+q))$／非負の元の係数比較 2 件）と、倍数でない辺の上からの評価を第一の $k$ で読み最初の二つの項を加法単調性で置き換える本体三段・推移律。
  SageMath `check/open-square-large-side-density-upper-vs-base-side/`（$(a,L)=(1,2),(1,3)$ × 6 点、168 検査、11 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareLargeSideDensityUpperVsBaseSide.lean`（`exists_multiple_side_below_of_lt`・`rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one`）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareLargeSideDensityUpperVsBaseSide.lean`（`upper_bound_enlarge_first_two_terms_necSuf`。`[AddCommMagma X]` と推移律・右加法単調性・交換則だけ）、導出版。sorry 検査 1300 件。
  割った理由: 上端は係数を大きくするだけだが、下端は非正の元の係数比較と逆元の項の比較・分配則を要する別の論法。$E$ の形も、上端・下端の係数を $\frac1a$ でくくれる $E:=4\iota(\ell_2)+8\iota(\log(1+q))-4\iota(\log q)$ ではなく上端・下端それぞれの実際の係数で書き、Cauchy 性で足すことにした（備考を更新）。前 tick のレビューでは修正なし。次は「基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（$0<q\le1$）」。

- **2026-08-16 の tick 347 は、台帳の先頭行「倍数でない辺の密度の基準辺の密度による下からの評価（$0<q\le1$）」（$a,k\ge1$、$ka<L\le ka+a$、$0<q\le1$ で $\frac2L\iota(\log q)+\frac2a\iota(\log q)+\Psi^{\mathrm{op}}_a+\bigl(-\frac{2a}L\cdot(\iota(\ell_2)+2\iota(\log(1+q)))\bigr)\le\Psi^{\mathrm{op}}_L$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one`（`claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 3 つ（$\mathbb Q$ の係数 $\frac{(ka)^2}{L^2}+\frac{L^2-(ka)^2}{L^2}=1$・$0\le\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$（倍数辺との平方の差）／符号 $0\le C:=\iota(\ell_2)+2\iota(\log(1+q))$（埋め込んだ対数の順序・非負有理数倍・加法単調性）／$\frac{L^2-(ka)^2}{L^2}\Psi_{ka}\le\frac{L^2-(ka)^2}{L^2}C\le\frac{2a}LC$（上からの評価を $L:=ka$ で読む・非負有理数倍の順序保存・非負の元の係数比較））と、本体三つ（分配則で $\Psi_{ka}$ を割って加法単調性／$-\frac{2a}LC$ を足して結合則・逆元・単位元／倍数辺の差の評価の左と誤差評価の左へ加法単調性・推移律）。
  SageMath `check/open-square-non-multiple-side-density-lower-vs-base-side/`（$(a,k,L)$ 三組（$L\le3$）× 6 点、396 検査、10 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareNonMultipleSideDensityLowerVsBaseSide.lean`（`rationalLogOrderLE_zero_openSquareUpperBoundConstant`・`rationalLogOrderLE_openSquareNonMultipleSideDensity_lower_vs_baseSide_of_le_one`）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareNonMultipleSideDensityLowerVsBaseSide.lean`（`lower_bound_split_and_shift_necSuf`。`[AddCommMonoid X] [Neg X]` と推移律・右加法単調性・逆元 $x+(-x)=0$ だけ。`AddCommGroup` は要らない）、導出版。sorry 検査 1296 件。
  前 tick のレビューでは修正なし。次は「基準辺の平方以上の辺の密度と基準辺の密度の一様な差の評価（$0<q\le1$）」（場合分けの本体。台帳の備考）。

- **2026-08-16 の tick 346 は、台帳の先頭行「倍数でない辺の密度と基準辺の密度の差の評価」を上端と下端の二行へ割り、その上端「倍数でない辺の密度の基準辺の密度による上からの評価」（$a,k\ge1$、$ka<L\le ka+a$、$0<q\le1$ で $\Psi^{\mathrm{op}}_L\le\frac{2a}L\iota(\ell_2)+\frac{4a}L\iota(\log(1+q))+\Psi^{\mathrm{op}}_a$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one`（`claim_open_square_multiple_side_density_vs_base_side_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 3 つ（$\mathbb Q$ の係数比較 $\frac{(ka)^2}{L^2}\le1$／符号 $0\le\Psi^{\mathrm{op}}_{ka}$（`claim_open_square_free_entropy_density_nonnegative` を $L:=ka$ で読む）／非負の元の係数比較 $\frac{(ka)^2}{L^2}\Psi_{ka}\le1\cdot\Psi_{ka}=\Psi_{ka}\le\Psi_a$（`claim_open_square_multiple_side_density_vs_base_side_le_one` の右へ推移律））と、誤差評価の右・加法単調性（交換則で末尾の項を先頭へ寄せる）・推移律の本体二段。
  SageMath `check/open-square-non-multiple-side-density-upper-vs-base-side/`（$(a,k,L)$ 三組（$L\le3$）× 6 点、180 検査、10 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareNonMultipleSideDensityUpperVsBaseSide.lean`（`multipleSide_square_ratio_le_one`・`rationalLogOrderLE_openSquareNonMultipleSideDensity_upper_vs_baseSide_of_le_one`）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareNonMultipleSideDensityUpperVsBaseSide.lean`（`upper_bound_enlarge_last_term_necSuf`。`[AddCommMagma X]` と推移律・右加法単調性・交換則だけ）、導出版。sorry 検査 1292 件。
  割った理由: 上端は非負の係数比較で $\Psi_{ka}$ の項を $\Psi_a$ へ置き換えるだけだが、下端は $\frac{(ka)^2}{L^2}\Psi_{ka}$ を $\Psi_{ka}$ と誤差 $\frac{L^2-(ka)^2}{L^2}\Psi_{ka}$ に分けて上からの評価 $C$ で押さえ、逆元を足して移項する別の論法なので、二行に分けた。前 tick のレビューでは修正なし。次は「倍数でない辺の密度の基準辺の密度による下からの評価（$0<q\le1$）」。

- **2026-08-16 の tick 345 は、台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を論法の数で四行へ割り、その最初「倍数辺の密度と基準辺の密度の差の評価」（$a,k\ge1$、$0<q\le1$ で $\frac2a\iota(\log q)+\Psi^{\mathrm{op}}_a\le\Psi^{\mathrm{op}}_{ka}\le\Psi^{\mathrm{op}}_a$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_multiple_side_density_vs_base_side_le_one`（`claim_open_square_multiple_side_subsquare_density_error_bound` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 3 つ（$\mathbb Q$ の係数比較 $\frac{2(k-1)}{ka}\le\frac{2k}{ka}=\frac2a$／符号 $\iota(\log q)\le0$（埋め込んだ対数の順序を $q':=1$ で読む）／非正の元の係数比較）と、加法単調性・推移律による左の二段。右はブロック敷き詰め密度の右そのもの。
  SageMath `check/open-square-multiple-side-density-vs-base-side/`（$(a,k)$ 五組（$ka\le3$）× 6 点、270 検査、19 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareMultipleSideDensityVsBaseSide.lean`（`blockTiling_lower_coefficient_le_two_div`・`rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one`）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareMultipleSideDensityVsBaseSide.lean`（`twoSided_bounds_enlarge_lower_coefficient_necSuf`。推移律・右加法単調性だけ。上端に触れないので交換則も要らない）、導出版。sorry 検査 1288 件。
  割り方: 「倍数辺の密度と基準辺の密度の差の評価」→「倍数でない辺の密度と基準辺の密度の差の評価」→「基準辺の平方以上の辺の密度と基準辺の密度の一様な差の評価」→「密度の列の Cauchy 性」（手順は台帳の備考）。前 tick のレビューでは修正なし。次は「倍数でない辺の密度と基準辺の密度の差の評価（$0<q\le1$）」。

- **2026-08-16 の tick 344 は、台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」（$k\ge1$、$ka<L\le ka+a$、$0<q\le1$ で $\frac2L\iota(\log q)+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}\le\Psi^{\mathrm{op}}_L\le\frac{2a}L\iota(\ell_2)+\frac{4a}L\iota(\log(1+q))+\frac{(ka)^2}{L^2}\Psi^{\mathrm{op}}_{ka}$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_multiple_side_subsquare_density_error_bound`（`claim_rational_embedded_log_order_iff` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 4 つ（部分正方形比較を $a:=ka$ で読む／$\mathbb Q$ の係数比較 $\frac{ka+L}{L^2}\le\frac2L$・$\frac{L^2-(ka)^2}{L^2}\le\frac{2a}L$（倍数辺との平方の差）・$\frac{2(L^2-(ka)^2)}{L^2}\le\frac{4a}L$／符号 $\iota(\log q)\le0$・$0\le\iota(\ell_2)$・$0\le\iota(\log(1+q))$（埋め込んだ対数の順序を $q':=1$、$(1,2)$、$(1,1+q)$ で読み $\log1=0$・$\iota(0)=0$・$\log2=\ell_2$）／係数の大小による有理数倍の比較（非正 1 件・非負 2 件））と、加法単調性・推移律による本体（左二段・右三段）。
  SageMath `check/open-square-multiple-side-subsquare-density-error-bound/`（形の三組 $(a,k,L)=(1,1,2),(2,1,3),(1,2,3)$ × 6 点、342 検査、11 秒。一辺 4 以上は配位和が長いので含めない）。Lean 具体版 `ThermodynamicLimit/OpenSquareMultipleSideSubsquareDensityErrorBound.lean`（`rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one`。補助に `toRational_zero` と符号の三つ）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareMultipleSideSubsquareDensityErrorBound.lean`（`twoSided_bounds_enlarge_coefficients_necSuf`。関係の推移律・右加法の単調性・加法の交換則だけ。結合則も係数も要らない）、導出版。sorry 検査 1284 件。
  レビューでは前 tick の statement の読み方の例に主張自身の変数 $q$ を再利用していた箇所を $p$ に改めた（先に別コミットで push 済み）。次は「密度の列の Cauchy 性（$0<q\le1$）」。
（これより古い 300 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 11 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 67 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（$0<q\le1$） | todo | $a\ge1$、$a<L$、$a^2\le L$、$0<q\le1$ で $\frac4a\iota(\log q)+\Psi^{\mathrm{op}}_a+\bigl(-\frac2a(\iota(\ell_2)+2\iota(\log(1+q)))\bigr)\le\Psi^{\mathrm{op}}_L$。上端（`claim_open_square_large_side_density_upper_vs_base_side_le_one`）と同じく `exists_multiple_side_below_of_lt`（自然数の除法。$k:=\lfloor(L-1)/a\rfloor$、$k\ge1$、$ka<L\le ka+a$）で $k$ を取り、「倍数でない辺の密度の基準辺の密度による下からの評価」を読む。係数は $L\ge a^2$・$L>a$ から $\frac2L\le\frac2a$（$L\ge a$）、$\frac{2a}L\le\frac2a$（$\mathbb Q$）で $a$ だけの形へ。$\iota(\log q)\le0$ なので $\frac2L\iota(\log q)\ge\frac2a\iota(\log q)$（非正の元の係数比較 `claim_rational_log_order_group_scalar_compare_nonpos`）、$-\frac{2a}LC\ge-\frac2aC$（$0\le C$、非負の係数比較を逆元へ移す。逆元の順序反転が本文に無ければ $C$ の係数比較を先に取ってから逆元を足す形で書く）。$\frac2L\iota(\log q)+\frac2a\iota(\log q)$ を $\frac2a\iota(\log q)+\frac2a\iota(\log q)=\frac4a\iota(\log q)$（分配則）へ |
| 熱力学極限 | 密度の列の Cauchy 性（$0<q\le1$） | todo | $\bigl(\Psi^{\mathrm{op}}_L(q)\bigr)_L$ が `def_rational_log_order_group_cauchy_sequence` の Cauchy 列であること。上端・下端の一様な評価から、$a\ge1$、$L,M\ge a^2$、$L,M>a$ で $\Psi_L-\Psi_M$ を $\pm\frac1aE$、$E:=2\iota(\ell_2)+4\iota(\log(1+q))-4\iota(\log q)+\bigl(2\iota(\ell_2)+4\iota(\log(1+q))\bigr)$ の形（上端の項と下端の項の和。$0\le E$、$a,L,M$ によらない）で挟む。$\varepsilon$ に対し `claim_rational_log_order_group_archimedean` で $E\le n\cdot\varepsilon$ となる $n$ を取り、$a:=n+1$（$a\ge2$ なので $a<a^2$）、$N:=a^2$。$L,M\ge N$ で $\Psi_L-\Psi_M=(\Psi_L-\Psi_a)-(\Psi_M-\Psi_a)$。完備性も極限論も使わない。論法が二つ以上なら着手時に割る（差の挟み込みと Cauchy 性本体）。$1\le q$ は部分正方形比較の $1\le q$ 版が無いので後回し（必要なら行を足す） |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-17（tick 348）: 台帳の先頭行「基準辺の平方以上の辺の密度と基準辺の密度の一様な差の評価（$0<q\le1$）」は上端（係数を $a$ だけの形へ大きくする）と下端（非正の元の係数比較・逆元の項の比較・分配則）で論法が違うので二行へ割った。その上端「基準辺の平方以上の辺の密度の基準辺の密度による一様な上からの評価」を実行し、`claim_open_square_large_side_density_upper_vs_base_side_le_one` を `claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one` の直後に置いた。
  仮定は $a\ge1$・$a<L$・$a^2\le L$（$a=1$ で $L=1$ を除くため $a<L$ を置く。Cauchy 性では $a\ge2$ から出る）。証明は自然数の除法で $k$ を取って倍数でない辺の上からの評価を読み、係数比較・符号・非負の係数比較・加法単調性・推移律。SageMath `open-square-large-side-density-upper-vs-base-side`、Lean 具体版・必要十分版（`AddCommMagma`、推移律・右加法単調性・交換則だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1300 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 347）: 台帳の先頭行「倍数でない辺の密度の基準辺の密度による下からの評価（$0<q\le1$）」を実行し、`claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one` を `claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one` の直後に置いた。
  証明は台帳の備考のとおり（$\Psi_{ka}$ を分配則で $\frac{(ka)^2}{L^2}\Psi_{ka}+\frac{L^2-(ka)^2}{L^2}\Psi_{ka}$ に割り、誤差を上からの評価 $C$ と倍数辺との平方の差で $\frac{2a}LC$ に押さえ、$-\frac{2a}LC$ を足して移項、倍数辺の差の評価の左と誤差評価の左へ推移律）。SageMath `open-square-non-multiple-side-density-lower-vs-base-side`、Lean 具体版・必要十分版（`AddCommMonoid`・`Neg`、推移律・右加法単調性・逆元 $x+(-x)=0$ だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1296 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 346）: 台帳の先頭行「倍数でない辺の密度と基準辺の密度の差の評価（$0<q\le1$）」は上端（非負の係数比較で $\Psi_{ka}$ の項を $\Psi_a$ へ置き換える）と下端（$\frac{(ka)^2}{L^2}\Psi_{ka}$ を $\Psi_{ka}$ と誤差に分けて上からの評価で押さえ、逆元を足して移項する）で論法が違うので二行へ割った。その上端「倍数でない辺の密度の基準辺の密度による上からの評価」を実行し、`claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one` を `claim_open_square_multiple_side_density_vs_base_side_le_one` の直後に置いた。
  証明は $\frac{(ka)^2}{L^2}\le1$・密度の非負性・非負の係数比較・倍数辺の差の評価の右・誤差評価の右・加法単調性（交換則）・推移律。SageMath `open-square-non-multiple-side-density-upper-vs-base-side`、Lean 具体版・必要十分版（`AddCommMagma`、推移律・右加法単調性・交換則だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1292 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 345）: 台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」は、倍数辺の差の評価・倍数でない辺の差の評価・基準辺の平方以上での一様な差の評価・Cauchy 性本体の四つの論法を含むので四行へ割った（手順は台帳の備考）。その最初「倍数辺の密度と基準辺の密度の差の評価」を実行し、`claim_open_square_multiple_side_density_vs_base_side_le_one` を `claim_open_square_multiple_side_subsquare_density_error_bound` の直後に置いた。
  証明はブロック敷き詰め密度の下端の係数 $\frac{2(k-1)}{ka}$ を $\frac2a$ へ大きくする（$\mathbb Q$ の係数比較・符号 $\iota(\log q)\le0$・非正の元の係数比較・加法単調性・推移律）。SageMath `open-square-multiple-side-density-vs-base-side`、Lean 具体版・必要十分版（推移律・右加法単調性だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1288 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 344）: 台帳の先頭行「倍数辺の部分正方形による密度の挟み込みの誤差評価」を実行した。`claim_open_square_multiple_side_subsquare_density_error_bound` を `claim_rational_embedded_log_order_iff` の直後に置いた。
  証明は台帳の備考のとおり（部分正方形比較を $a:=ka$ で読み、係数を倍数辺との平方の差と $ka+L\le2L$ で大きくし、符号は埋め込んだ対数の順序から、係数比較（非負・非正）と加法単調性・推移律でつなぐ）。SageMath `open-square-multiple-side-subsquare-density-error-bound`、Lean 具体版・必要十分版（推移律・右加法単調性・交換則だけ）・導出版を書き、入口 import・sorry 検査へ 7 件登録（計 1284 件）。式変形統一は一時停止中のため実施せず。
（これより古い 310 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録

- 2026-08-17（tick 348）: 前 tick の「倍数でない辺の密度の基準辺の密度による下からの評価」の本文（準備 3 つ・本体三つ）・SageMath overview（396 検査）・Lean 具体版（`hsum`・`hd0`・`hde`・`hC0`・`hm`・`hsplit`・`h1'`・`hshift`・`h3`〜`h5` が本文の準備第一〜第三と本体 (1)〜(3) に 1 対 1）・必要十分版（`AddCommMonoid`・`Neg`、推移律・右加法単調性・逆元）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は誤差評価の下端の項を基準辺の密度で置き換える比較で、一様な下からの評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 347）: 前 tick の「倍数でない辺の密度の基準辺の密度による上からの評価」の本文（準備 3 つ・本体二段）・SageMath overview（180 検査）・Lean 具体版（`multipleSide_square_ratio_le_one`・`rationalLogOrderLE_zero_openScaledFreeEntropy`・`rationalLogOrderLE_ratSmul_le_ratSmul_of_le`・`one_smul`・`rationalLogOrderLE_add_right`（`add_comm` で寄せる）・`rationalLogOrderLE_trans` が本文の準備第一〜第三と本体に 1 対 1）・必要十分版（`AddCommMagma`、推移律・右加法単調性・交換則）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は誤差評価の上端の項を基準辺の密度で置き換える比較で、Cauchy 性の一様な差の評価が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 346）: 前 tick の「倍数辺の密度と基準辺の密度の差の評価」の本文（準備 3 つ・左二段・右）・SageMath overview（270 検査）・Lean 具体版（`blockTiling_lower_coefficient_le_two_div`・`rationalLogOrderLE_toRational_logRat_nonpos_of_le_one`・`rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos`・`rationalLogOrderLE_add_right`・`rationalLogOrderLE_trans` が本文の準備第一〜第三と本体に 1 対 1）・必要十分版（推移律・右加法単調性）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は下端の係数を $k$ によらない形へ大きくする比較で Cauchy 性の倍数辺の側が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 345）: 前 tick の「倍数辺の部分正方形による密度の挟み込みの誤差評価」の本文（準備 4 つ・左二段・右三段）・SageMath overview（342 検査）・Lean 具体版（`hc1`〜`hc3`・`hs1`〜`hs3`・`hm1`〜`hm3`・`hmid1`・`hmid2` が本文の準備の第二〜第四と本体に 1 対 1）・必要十分版（推移律・右加法単調性・交換則）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は係数を $L,k$ によらない形へ大きくする比較で Cauchy 性の非倍数辺の側が引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 344）: 前 tick の「埋め込んだ対数の順序は正の有理数の順序と一致する」の本文（同値の四段の鎖）・SageMath overview（900+900+42 検査）・Lean 具体版（`Nat.cast_one, one_pow, div_one, one_smul` と `logRat_le_iff` の合成が本文と 1 対 1）・必要十分版・導出版を突き合わせ、根拠が一致した。
  修正 1 件: statement の読み方の例「$q:=1,\ q':=1+q$」が主張自身の変数 $q$ を代入先と代入する値の両方に使っていた（1 記号 1 意味に反する）ので、読む側の有理数を $p$ と書いて「$q:=1,\ q':=1+p$」へ改めた。「何も言っていない主張」の観点: 順序を移し合う同値で誤差評価が三度引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。
（これより古い 331 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。
