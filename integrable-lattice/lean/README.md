# Lean 4 + mathlib4 による機械的証明（integrable-lattice）

`integrable-lattice` の人手証明のうち、形式化できるものを Lean 4 + mathlib4 で機械的に検証する。

**形式化の対象**は `outputs/paper-plans/002_R_Lambda_duality.md` §2
「現時点で厳密に確定している部分命題」の **命題 A, B, C, N, L, T, V, W** である。

**新規性は主張しない。** ここで扱う命題はいずれも既知内容の再框であり（002 §7 の
`resolved_risk` / `novelty_risk` を参照）、Lean 化もその一部である。

## セットアップ

### 1. elan（Lean のツールチェーン管理ツール）

```bash
curl -fsSL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -o elan-init.sh
sh elan-init.sh -y
export PATH="$HOME/.elan/bin:$PATH"   # 恒久化するには shell の rc に追記
```

`lean-toolchain` にツールチェーンが固定してあるので、このディレクトリで `lake` を実行すれば
elan が自動的に該当バージョン（`leanprover/lean4:v4.32.1`）を取得する。

### 2. 依存の取得と mathlib のビルド済みキャッシュ

```bash
cd integrable-lattice/lean
lake exe cache get     # mathlib のビルド済み .olean を取得（初回は数 GB のダウンロード）
lake build
```

`lake exe cache get` を省略すると mathlib 全体をローカルでビルドすることになるので必ず実行する。

### 3. バージョン固定（`exact-solution-of-2d-ising-model/lean/` と同一タグ）

| ファイル | 内容 |
| --- | --- |
| `lean-toolchain` | `leanprover/lean4:v4.32.1` |
| `lakefile.toml` | mathlib4 を git tag `v4.32.1` に固定 |
| `lake-manifest.json` | mathlib4 と推移的依存の commit を固定（コミット対象） |

**mathlib のタグは `exact-solution-of-2d-ising-model/lean/` と揃えてある。**
環境の再現性のためであり、更新するときは両プロジェクトを同じタグへ同時に動かす。
`lean-toolchain` と `lakefile.toml` の `rev` が揃っていないとビルド済みキャッシュが使えない。

## ビルドと sorry ゼロの確認

```bash
cd integrable-lattice/lean
lake build
./scripts/check-no-sorry.sh   # 終了コード 0 なら OK
```

`scripts/check-no-sorry.sh` は `exact-solution-of-2d-ising-model/lean/scripts/check-no-sorry.sh`
と同じ方式で、次の 2 つを検査する。

1. ソース中に `sorry` / `admit` が残っていないこと（grep）。
2. 実際に証明した定理の `#print axioms` に `sorryAx` が現れないこと
   （`propext` / `Classical.choice` / `Quot.sound` は mathlib 標準の 3 公理で問題ない）。

実行ログは `logs/` に保存してある（`logs/check-no-sorry.log`, `logs/build.log`,
`logs/cache-get.log`）。新しい定理を追加したらスクリプトの `targets` 配列にも追加すること。

## 人手証明との対応の付け方

- 対応は **002 の命題名（命題 A 等）と根拠 report のパス** で辿る。ファイルパスには依存させない。
- 各 Lean ファイルの冒頭コメントに、対応する命題名と report のパス、および
  **人手証明のどの主張を形式化し、どの主張を形式化していないか** を明記する。
- 人手証明のステートメントをそのまま形式化できない場合は、冒頭コメントに
  その理由と、形式化した修正版ステートメントを書く（例: `TruncVal.lean` の `padicValInt 0 = 0` 問題）。

| Lean モジュール | 対応する 002 の命題 | 根拠 report |
| --- | --- | --- |
| `IntegrableLattice/TruncVal.lean` | 命題 A (3) の切断付値 | `outputs/reports/cycle3_T1_D-U2_rigorous.md` |
| `IntegrableLattice/PropA.lean` | 命題 A (1)(2)(3) | `outputs/reports/cycle3_T1_D-U2_rigorous.md` |
| `IntegrableLattice/PropL.lean` | 命題 L | `outputs/reports/cycle8_T1_lte_proposition.md` |
| `IntegrableLattice/PropV.lean` | 命題 V（補題 V0 とその帰結、$d=1,2$） | `outputs/reports/cycle14_T1_vp_growth_two_variable.md` |
| `IntegrableLattice/PropC.lean` | 命題 C の代数的核 | `outputs/reports/cycle3_T1_D-U2_rigorous.md` |
| `IntegrableLattice/PropCPeriod.lean` | 命題 C の周期の整除 $\pi(p,k)\mid p^{k-1}\pi(p,1)$ | `outputs/reports/cycle3_T1_D-U2_rigorous.md` |
| `IntegrableLattice/PropB.lean` | 命題 B の片方向（$\mathrm{lcm}\mid\pi(p,1)$ のみ） | `outputs/reports/cycle3_T1_D-U2_rigorous.md` |
| `IntegrableLattice/PropBTracePeriod.lean` | 命題 B（**訂正後**の等式本体・両方向）と、人手証明のステートメントへの反例 | `sagemath/check/cycle3_T3_period/pi_p1_refined_README.md`（cycle 8）、`outputs/reports/cycle17_ops_lean_propB.md` |
| `IntegrableLattice/PropN.lean` | 命題 N の下界方向（Cayley–Hamilton だけで出る形）と、例外集合が無限になる反例 | `outputs/reports/cycle3_T1_D-U2_rigorous.md` の**「命題 B」節**（＝本文の命題 N。本文の命題 B とは別物）、`outputs/reports/cycle18_ops_lean_props_NTW.md` |
| `IntegrableLattice/PropT.lean` | 命題 T の代数的な段・奇数性が効く 2 箇所・Newton 多角形の組合せ核・総和の段 | `outputs/reports/cycle13_T1_observation_T_settlement.md`、`outputs/reports/cycle18_ops_lean_props_NTW.md` |
| `IntegrableLattice/PropW.lean` | 命題 W の非退化性判定（`Decidable`）と、閉形式の $\nu$ が一般に整数でないこと | `outputs/reports/cycle14_T3_two_variable_criterion.md`、`outputs/reports/cycle18_ops_lean_props_NTW.md` |
| `IntegrableLattice/PropCTracePeriod.lean` | 命題 C′（トレース列の周期の上界）の使われ方の検算と、命題 C″（cycle 19 の定理 A′・改良した上界・閉形式の不存在） | `outputs/reports/cycle18_T3_trace_period_bound.md`、`outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md` |

## 形式化の現状

判定語: **完了** / **部分的**（何が残っているか明記） / **未着手**（なぜかを一次情報で明記）。

| 命題 | 状態 | 内容 | 残り／理由 |
| --- | --- | --- | --- |
| **A**（$v_p$ の最終周期性） | **完了**（(1)(2)(3)）／(4) は非該当 | `exists_eventually_periodic_pow`（有限モノイドの鳩の巣）、`exists_eventually_periodic_matrixPow`、`exists_eventually_periodic_trace`、`exists_eventually_periodic_truncVal`、`exists_eventually_periodic_min_padicValInt` | (4)「有限手続きで決定可能」は計算可能性の主張であって命題ではないので Lean の定理にしていない |
| **L**（LTE, $P(z)=z-c$） | **完了**（4 分岐すべて） | `padicValNat_pow_sub_one_of_dvd`（$p\mid c$）、`padicValNat_pow_sub_one_of_not_dvd_order`（$d\nmid L$）、`padicValNat_pow_sub_one_odd`（$p$ 奇・$d\mid L$）、`padicValNat_two_pow_sub_one_odd_exp` / `..._even_exp`（$p=2$） | — |
| **V**（$\Lambda$ 側の非自明性判定） | **完了**（$d=1$ と $d=2$） | `X_pow_char_pow_sub_one`（核 $z^{p^n}-1=(z-1)^{p^n}$）、`resultant_X_pow_char_pow_sub_one`、`aOne_cast_zmod` / `dvd_aOne_iff`（$d=1$）、`aTwo_cast_zmod` / `dvd_aTwo_iff`（$d=2$） | 人手証明どおり $a_L$ を終結式で定義したまま形式化できた（mathlib の `Polynomial.resultant` を使用）。$d\ge3$ は同じ補題の反復で出るが未記述 |
| **C**（Pisano 型上界） | **完了**（整除方向）／等号は非該当 | 代数的核（`PropC.lean`）: `dvd_one_add_pow_prime_sub_one`、`dvd_pow_prime_pow_sub_one`、`pow_prime_pow_eq_one_of_eq_one_add` / `matrix_pow_prime_pow_eq_one`。**周期そのもの**（`PropCPeriod.lean`）: `matrix_pow_mul_prime_pow_eq_one`、`orderOf_dvd_mul_prime_pow`、`orderOf_reduction_dvd`（＝$\pi(p,k)\mid\pi(p,1)p^{k-1}$）、純周期性の正当化 `isUnit_pow_add_eq_iff` / `isUnit_map_of_not_dvd_det`（$p\nmid\det T$） | 等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）は**人手証明のとおり一般には偽**（cycle 6 で六頂点 572 件中 4.5% の反例）なので形式化対象ではない。「最終周期の最小値」を `Nat.find` で定義する代わりに、可逆性から最終周期の条件が $A^t=1$ と同値であることを示して `orderOf` で述べた |
| **B**（$\pi(p,1)$ の精密公式） | **完了**（訂正後のステートメントについて等式・両方向）／原ステートメントは**偽** | `PropBTracePeriod.lean`: `eq_zero_of_expSum_pow_eq_zero`（指標の一次独立を Vandermonde で）、`expSum_eventually_periodic_iff`／`..._lcm_dvd`（$t$ が周期 $\iff\operatorname{lcm}\{\operatorname{ord}\lambda:m_\lambda\neq0\}\mid t$。**逆方向を含む**）、`isLeast_period_expSum`（最小周期＝lcm）、`trace_pow_eq_sum_maxGenEigenspace`（人手証明の第 1 段 $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$ を一般化固有空間分解から証明）、`trace_pow_eventually_periodic_iff`（代数閉体・固有値非零での仮定なし完成形）、`natCast_ne_zero_iff_not_dvd`（$m_\lambda\neq0$ in $K$ $\iff p\nmid m_\lambda$）。反例: `orderOf_cexMat`（$=3$）と `trace_cexMat_pow`（$\equiv0$） | **訂正**: 人手証明は $\pi(p,1)$ を命題 A の「行列冪列 $T^N\bmod p$ の最終周期」と書いているが、証明が計算しているのは「トレース列 $\operatorname{Tr}T^N\bmod p$ の最終周期」である。両者は一致せず（$4\times4$ の反例を Lean で形式化。ランダム標本 2487 例中 563 例＝22.6% で不一致）、**原ステートメントは偽**。トレース列の読みでは等式が両方向とも成り立つ。cycle 16 の「残るのは組み立てだけ」という記述もこの読み違いに基づいており、誤りだった。**未形式化**: 具体行列 $T\bmod p$ から $\overline{\mathbb{F}_p}$ への係数拡大の移送（数学的には自明だが Lean 内では未接続） |
| **N**（線形成長率＝Newton 多角形） | **部分的**（下界方向のみ）／本文を**訂正**した | `PropN.lean`: `trace_pow_add_eq_neg_sum`（Cayley–Hamilton 由来の線形漸化式）、`trace_pow_dvd_of_charpoly_coeff_dvd`（係数条件 $p^{m(d-i)}\mid c_i$ から $p^{mN}\mid p^{md}Z_N$。**固有値も Newton 多角形も $\mathbb{Q}_p$ も使わない**）、`le_padicValInt_trace_pow`（付値版）。反例: `trace_cexN_pow_odd` / `cexN_exceptional_unbounded` | **訂正**: 本文の「Skolem–Mahler–Lech 型の例外は**有限個の $N$**」は誤りで、例外集合は算術級数の有限和＝一般に**無限**（$T=(0\,1;2\,0)$, $p=2$ で全奇数 $N$ が例外）。根拠 report は「算術級数の有限和」と正しく書いていた。**未形式化**: 上界方向（SML / Strassmann が mathlib に無い）、鋭い下界（オフセット無し。Newton 恒等式の行列トレースへの接続が要る。恒等式自体は mathlib にある）、Newton 多角形と固有値の接続（$\overline{\mathbb{Q}_p}$ の付値が要る） |
| **T**（$v_2(\tau(L))=2(L-1)$） | **部分的**（代数的な段と算術の段）／本文に食い違いなし | `PropT.lean`: `prod_sub_pow_eq`、`prod_A_sub_zeta_eq`（人手証明 (3.1)）、`not_dvd_two_mul_of_odd` / `padicValNat_two_eq_zero_of_odd`（奇数性が効く 2 箇所）、`newton_two_root_valuations`（段 4 の組合せ核）、`v2_tau_eq_of_root_valuations`（段 5 の総和。外部依存を仮定として型に出した形） | **未形式化**: 段 1（matrix-tree。mathlib に全域木数の公式が**無い**）と段 3（2 の不分岐性と Hensel 持ち上げ。Hensel 自体は mathlib に**在る**が $\mathbb{Q}(\zeta_L)$ の完備化への配線が無い）。本文の数値（奇 $L$ の $2(L-1)$、偶 $L$ の $5,19,29,61,53,83,77$）は素の Python で独立に再計算して全一致 |
| **W**（非退化グラフ塔の閉形式） | **部分的**（判定条件のみ）／本文へ**帰属を追記**した | `PropW.lean`: `NoProjZero`（非退化性の定義と `Decidable` インスタンス）、`torus_nondegenerate_three` / `torus_degenerate_two`（本文の適用例 2 つを `decide` で検算）、`exists_proj_zero_of_linear`（非退化なら $k\ge2$）、`quintic_cubic_nondegenerate`、`propW_nu_not_integer_of_ell_five_k_three` | **追記**: 本文は $\nu$ の帰属を書いていなかったが、$\frac{k(\ell+1)}{\ell-1}$ は一般に非整数（$\ell=5,k=3$ で $9/2$。この $(\ell,k)$ は非退化性と両立する）なので $\nu\in\mathbb{Q}$ であって一般に $\mathbb{Z}$ ではない。**未形式化**: 閉形式本体。上界方向が Cuoco–Monsky に依拠し、岩澤型漸近は mathlib に無い（cycle 16・18 の grep で一致）。matrix-tree も要る |
| **C′・C″**（トレース列の周期） | **部分的**（核と反例）／本文に食い違いなし | `PropCTracePeriod.lean`: `TraceOrth` / `IsTracePeriodAt`（周期の内容）、`traceOrth_of_forall_pow`（生成元の冪だけから全 $x$ へ）、`dvd_of_mulVec_dvd`（定理 6 の Smith 標準形の段を $HG=p^wI$ の形で）、`traceOrth_one_add_pow`（**定理 A′ の心臓部**）、`isTracePeriodAt_mul_prime`（$t_{k+1}\mid p\,t_k$）、反例 `lucas_two_power_not_period`（命題 12）・`trace_period_not_affine`（閉形式の不存在） | **食い違いは無かった**が、**過剰仮定を 2 件検出**: (1) 定理 A′ の証明に $p$ の素数性は要らない（効くのは $\binom{p}{1}=p$ だけ）、(2)「周期」の最小性も使っていない（最小性を仮定すると結論が述べられない）。**未形式化**: 定理 W（$w^*$ の代数的閉形式）。mathlib には `traceDual` / `differentIdeal` / `aeval_derivative_mem_differentIdeal` / `conductor_mul_differentIdeal` が**在る**（`logs/mathlib-gap-survey-cycle19.log`）。無いのは (a) 重み付きトレース形式の Gram 行列への配線と (b) **整数行列の単因子**（`Basis.SmithNormalForm` は部分加群の基底の形でしか無い）である |

### mathlib 欠落調査の一次情報（2026-07-31 再実施、mathlib commit `520045ab14e2` / v4.32.1）

`scripts/mathlib-gap-survey.sh` を実行した生ログが `logs/mathlib-gap-survey-cycle16.log`。走査対象は
`Mathlib/**/*.lean` **8264 ファイル**。各概念について 3 段で引いている（理由は下の「訂正」を見よ）。

| 概念 | (1) 連結語の内容 grep | (2) 語幹 (-i) の内容 grep | (3) 語幹 (-i) のファイル名 | 判定 |
| --- | --- | --- | --- | --- |
| $p$ 進 Newton 多角形 | `NewtonPolygon` 0 件 | `newton` 7 件 | 2 件 | **無い**。7 件は Newton–Raphson 法（`Dynamics/Newton.lean`、`Padics/Hensel.lean`、`RingTheory/Henselian.lean`）と Newton 恒等式（`MvPolynomial/Symmetric/NewtonIdentities.lean`）で、**Newton 多角形は 1 件も無い**（中身を確認） |
| 下方凸包 | `lowerConvexHull` 0 件 | `convex hull` 多数 | 0 件 | 凸包そのものは `Analysis/Convex/` にあるが、**整数点の下方凸包＝付値多角形は無い** |
| Kirchhoff の matrix-tree 定理 | `matrixTree` 0 件 | `kirchhoff` **0 件** | **0 件** | **無い** |
| 全域木数 | `numSpanningTrees` 0 件 | `spanning tree` 3 件 | 0 件 | **数える定理は無い**。3 件は全域木の**存在**（`SimpleGraph/Acyclic.lean:457,464`）と arborescence で、個数の公式ではない |
| 岩澤不変量の漸近 | `IwasawaInvariant` 0 件 | `iwasawa` 6 件 | 1 件 | **無い**（内訳は上の命題 W の欄） |
| 固有値の代数的重複度 | `algebraicMultiplicity` 0 件 | `algebraic multiplicity` 1 件 | 0 件 | **ある**（下の「訂正」を見よ） |
| Jordan 標準形 | `JordanNormalForm` 0 件 | `jordan normal` 0 件 | 0 件 | 無い（ただし命題 B には不要と判明） |
| （対照）Weierstrass 準備 | `WeierstrassPreparation` 0 件 | `weierstrass` 42 件 | 5 件 | **ある**（下の「訂正」を見よ） |

#### 訂正: 「連結語の内容 grep が 0 件」を「mathlib に無い」の根拠にしてはならない

**2026-07-31 に、旧版の調査方法が実際に 2 件の誤りを生んでいたことが分かったので記録する。**
旧 `mathlib-gap-survey.sh` はキャメルケース連結語をファイル**内容**にだけ grep していた。その結果:

1. **`WeierstrassPreparation files=0`** と出たが、これは**偽陰性**だった。
   `Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean` は**実在する**。
   中身の宣言名が `IsWeierstrassDivisionAt` 等で、"WeierstrassPreparation" という連続文字列が
   ファイル内に一度も現れないだけである。
2. **命題 B の欄に「mathlib には固有値の重複度を $\overline{\mathbb{F}_p}$ 上で扱う直接の API が無い」と
   書いてあったのは誤りだった。** 代数的重複度は `Polynomial.rootMultiplicity` で表現でき、
   `Mathlib/LinearAlgebra/Eigenspace/Zero.lean:211`（`finrank_eigenspace_le`）が
   `φ.charpoly.rootMultiplicity μ` をまさに「algebraic multiplicity」と呼んでいる。
   さらに半単純性の判定は**両方向とも存在する**
   （`Module.End.isSemisimple_of_squarefree_aeval_eq_zero` = `Semisimple.lean:221`、
   `Module.End.IsSemisimple.minpoly_squarefree` = 同 246）し、代数閉体上の固有空間分解も
   `Module.End.IsSemisimple.iSup_eigenspace_eq_top`（`Eigenspace/Semisimple.lean:79`）としてある。
   **したがって命題 B の逆方向が未形式化なのは mathlib の欠落のせいではなく、
   単に本 step で組み立てをやっていないからである。**

現行スクリプトは (1) 連結語の内容 grep、(2) 語幹の case-insensitive 内容 grep、
(3) 語幹の case-insensitive **ファイル名**検索の 3 つを必ず取り、
**(2)(3) がともに 0 のときにだけ「無い」と書く**。0 でないときはヒットの中身を読んで判定する
（上の表の「判定」欄はすべて中身を読んだ結果である）。

### 形式化にあたって人手証明から変えた点（すべて該当ファイルの冒頭にも記載）

- **命題 A (3) の切断付値**: 人手証明は $\min(v_p(Z_N),k)$ と書くが、mathlib の規約 `padicValInt p 0 = 0`
  のため $Z_N=0$ で主張が壊れる（$0\equiv p^k$ なのに $\min(v_p 0,k)=0\neq k$）。そこで
  $k$ で切断した付値 `truncVal p k z := max\{ j \le k : p^j \mid z\}` を定義に採り、
  $z\neq0$ では $\min(v_p(z),k)$ に一致することを `truncVal_eq_min_padicValInt` で証明した。
  人手証明の文言どおりの版も `exists_eventually_periodic_min_padicValInt`（$Z_N\neq0$ を仮定）として置いた。
- **命題 L の $p=2$・$L$ 偶**: 人手証明の $v_2(c-1)+v_2(c+1)+v_2(L)-1$ は $\mathbb{N}$ の切り捨て引き算に
  なるので、両辺に $1$ を足した形で述べた（mathlib の `padicValNat.pow_two_sub_one` と同じ形）。主張は同値。
- **命題 L の $p$ 奇・$d\mid L$**: $v_p(L)$ がそのまま現れるのは $d\mid p-1$ ゆえ $p\nmid d$ だからである。
  人手証明はこれを暗黙に使っている。`multOrder_dvd_sub_one` として明示的に証明して使った。
- **命題 C の核**: 行列環は非可換だが、$U=1+pV$ の冪はすべて $V$ の多項式なので、
  可換環 $(\mathbb{Z}/p^k)[X]$ 上で証明してから `Polynomial.aeval V`（余域は非可換でよい）で移送した。

### 一次情報（実行ログ）

| ログ | 内容 |
| --- | --- |
| `logs/cache-get.log` | `lake exe cache get` の実行ログ。末尾 `Completed successfully in 85412 ms!` / `EXIT=0` |
| `logs/build.log` | `lake build` の実行ログ。末尾 `Build completed successfully (8661 jobs).` |
| `logs/check-no-sorry.log` | `scripts/check-no-sorry.sh` の出力。`sorry`/`admit` なし、列挙した 31 個の定理はいずれも `sorryAx` に非依存（依存公理は `propext` / `Classical.choice` / `Quot.sound` のみ） |
| `logs/mathlib-gap-survey.log` | 未形式化命題の理由づけに使った mathlib の grep 結果（mathlib commit つき）。**方式に偽陰性があった旧版**。判断には下の cycle16 版を使うこと |
| `logs/build-cycle16-final.log` | cycle 16 の `lake build`。末尾 `Build completed successfully (8662 jobs).` / `BUILD_EXIT=0`（`PropCPeriod` 追加時点） |
| `logs/build-cycle16-propB.log` | `PropB` 追加後の `lake build`。末尾 `Build completed successfully (8663 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle16.log` | cycle 16 の `scripts/check-no-sorry.sh`。`sorry`/`admit` なし、列挙した **46 個**の定理はいずれも `sorryAx` に非依存 / `CHECK_EXIT=0` |
| `logs/mathlib-gap-survey-cycle16.log` | **3 段方式に直した**欠落調査の生ログ（走査 8264 ファイル、mathlib `520045ab14e2`） |
| `logs/cache-get-cycle16.log` | cycle 16 の `lake exe cache get`。末尾 `Completed successfully in 76454 ms!` / `CACHE_EXIT=0` |
| `logs/build-cycle17-propB.log` | cycle 17 step 3 の `lake build`。末尾 `Build completed successfully (8664 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle17.log` | cycle 17 step 3 の `scripts/check-no-sorry.sh`。列挙した **63 個**の定理はいずれも `sorryAx` に非依存 / `CHECK_EXIT=0` |
| `logs/cache-get-cycle17.log` | cycle 17 の `lake exe cache get`（worktree は依存が未取得なので毎回必要）。末尾 `Completed successfully in 32926 ms!` / `CACHE_EXIT=0` |
| `logs/build-cycle18-NTW.log` | cycle 18 step 3 の `lake build`。末尾 `Build completed successfully (8667 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle18.log` | cycle 18 step 3 の `scripts/check-no-sorry.sh`。列挙した **85 個**の定理はいずれも `sorryAx` 非依存 / `CHECK_EXIT=0` |
| `logs/cache-get-cycle18.log` | cycle 18 の `lake exe cache get` / `CACHE_EXIT=0` |
| `logs/mathlib-gap-survey-cycle18.log` | cycle 18 の欠落調査。SML・Strassmann・companion 行列・Newton 恒等式を検索語に追加した版 |
| `logs/build-cycle19-propC.log` | cycle 19 step 3 の `lake build`。末尾 `Build completed successfully (8668 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle19.log` | cycle 19 step 3 の `scripts/check-no-sorry.sh`。列挙した **107 個**の定理はいずれも `sorryAx` 非依存 / `CHECK_EXIT=0` |
| `logs/cache-get-cycle19.log` | cycle 19 の `lake exe cache get` / `CACHE_EXIT=0` |
| `logs/mathlib-gap-survey-cycle19.log` | cycle 19 の欠落調査（3 段方式）。`traceDual` / `differentIdeal` / Smith 標準形 / Lucas 数を検索語にした版。**`traceDual` と `differentIdeal` は実在する**ことを確認した記録 |
