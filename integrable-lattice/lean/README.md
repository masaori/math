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
| `IntegrableLattice/DigitTheorem.lean` | 命題 J の (J1)(J1′)（cycle 19 の定理 J2「桁定理」・命題 J2′） | `outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md` §2、`outputs/reports/cycle20_ops_lean_cycle19_theorems.md` |
| `IntegrableLattice/BouquetClosedForm.lean` | 命題 G′ の (G′3)（cycle 19 の命題 8・定理 X・定理 X′） | `outputs/reports/cycle19_T3_theta_infinity.md` §5、`outputs/reports/cycle20_ops_lean_cycle19_theorems.md` |
| `IntegrableLattice/TowerTypeCoefficients.lean` | 命題 J の (J4)（cycle 19 の定理 J6・定理 J7・定理 J8） | `outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md` §5、`outputs/reports/cycle20_ops_lean_cycle19_theorems.md` |
| `IntegrableLattice/DigitBranchRecursion.lean` | 命題 R の (R1)(R2)(R3)（cycle 20 の補題 L0・定理 L1・系 L2） | `outputs/reports/cycle20_T3_cancellation_recursion.md` §2–§3、`outputs/reports/cycle21_ops_lean_cycle20_theorems.md` |
| `IntegrableLattice/SInfinityDecision.lean` | 命題 K の (K2)(K3)(K6)（cycle 20 の補題 W2・定理 W3・系 W6） | `outputs/reports/cycle20_T3_s_infinity_decision.md` §2–§5、`outputs/reports/cycle21_ops_lean_cycle20_theorems.md` |
| `IntegrableLattice/EllTwoClosedForm.lean` | cycle 20 の定理 Y′・系 Y″（$\ell=2$ の族の閉形式。本文へは cycle 21 step 4 が反映予定） | `outputs/reports/cycle20_T3_ell_equals_2.md` §5、`outputs/reports/cycle21_ops_lean_cycle20_theorems.md` |
| `IntegrableLattice/DropAssumptionBStar.lean` | cycle 21 の定理 Q1（補題 Q2・Q3・Q5、定理 Q4、$(6.1)$ の組み立て。本文未反映） | `outputs/reports/cycle21_T3_drop_assumption_B_star.md` §3–§6、`outputs/reports/cycle22_ops_lean_cycle21_theorems.md` |
| `IntegrableLattice/GeneralTowerClosedForm.lean` | cycle 21 の定理 G1・G2・G3・G4（一般の塔の閉形式。本文未反映） | `outputs/reports/cycle21_T3_general_closed_form.md` §2–§5、`outputs/reports/cycle22_ops_lean_cycle21_theorems.md` |
| `IntegrableLattice/Cycle24Corrections.lean` | cycle 24 step 1 の訂正の検算（定理 D2・D3・D5、定理 G4 §5.3 条件 2、注 4.2、補題 Q5、定理 Q1）と系 G6・系 Q7 | `outputs/reports/cycle24_ops_fix_grounding_reports.md`、`outputs/reports/cycle24_ops_lean_cycle23_corrections.md` |
| `IntegrableLattice/Cycle25Corrections.lean` | cycle 25 step 1 の訂正の検算（**訂正後**の補題 Q5 の $c_1$、定理 Q1 の $b=0$、定理 G2 $(3.2)$ の規約）と、**本文へ入った命題 M・命題 U の照合**、$A_\mathrm{gen}$ のレベル非依存性 | `outputs/reports/cycle25_ops_fix_q5_c1_and_g2_cond32.md`、`outputs/reports/cycle25_ops_lean_cycle25.md`、本文 `structured-latex/content/010_general_closed_form.ts` |
| `IntegrableLattice/TracePeriodAssembly.lean` | 命題 C′ の上界そのものの組み立てと、命題 C″ の (2)(4) | `outputs/reports/cycle29_ops_formalization_triage.md` |
| `IntegrableLattice/PeriodicPointResultant.lean` | 本文の claim「周期点数は入れ子の終結式で厳密に計算できる」の内容（$d=1$・$d=2$ と、**一般の $d$**） | `outputs/reports/cycle29_ops_formalization_triage.md`、`outputs/reports/cycle29_ops_nested_resultant_general_d.md` |
| `IntegrableLattice/DualityPAdicFiniteL.lean` | 双対命題 D の ($p$ 素点, 有限 $L$) の段（$d=1$）。簡約周期点数の定義そのものと、それが終結式ひとつで書ける $0$ でない整数であること | `outputs/reports/cycle29_ops_duality_p_side.md` |
| `IntegrableLattice/WStarElementaryDivisors.lean` | $w^*$ を適合基底（Smith 標準形）の係数で定義し、最小元であることを証明した段。本文の $\det G=\pm N_{A/\mathbb{Q}}(\eta)$ と、Euler の双対基底公式の行列版 $C\,G=M_\eta$・$(\det C)^2=1$ | `outputs/reports/cycle29_ops_wstar_elementary_divisors.md` |

## 形式化の現状

**目標は論文の主張を全数形式化することである**（2026-08-03 ユーザー方針）。
一部の形式化で足れりとしない。

**現在の被覆（2026-08-04 実測）: 主張 24 件のうち 完了 6・部分的 16・未着手 2。全数まで残り 18 件。**
cycle 28 step 1 で命題 W* と命題 F が未着手から部分的へ移った。
cycle 29 step 1 は部分的 16 件を「素材が無い」と「配線をしていないだけ」へ仕分けし、
配線側から 3 件（周期点数の終結式表示・命題 C′・命題 C″）を実際に書いた。
cycle 29 step 2 は双対命題 D の $p$ 素点側を切り出し、未着手 → 部分的 へ動かした
（未着手 3 → 2・部分的 16 → 17）。
cycle 29 step 3 は **step 1 の「整数行列の単因子（Smith 標準形）が mathlib に無いので書けない」
という判定を覆した**——整除の鎖は確かに無いが $w^*$ に鎖は要らず、
適合基底（`Ideal.smithNormalForm` が返す形）の係数の $p$ 進付値の最大値として書ける。
$w^*$ の定義と最小性、$\det G=\pm N_{A/\mathbb{Q}}(\eta)$、Euler の双対基底公式の行列版が入った。
それでも命題 W\* は完了へ届いていない（体の上の等式を整数へ降ろす段と、$\rho$ が可約な場合が残る）。
cycle 29 step 3b は **周期点数の終結式表示を一般の $d$ で形式化し、この主張を完了させた**
（`nestedRes_eq_tupleProd`）。**残り 19 → 18。cycle 28 以来はじめて件数が減った。**
ここでも step 1 の壁の判定が覆った——反復多項式環を新しい型として再帰で組む必要は無く、
変数を 1 つだけ外へ出す `MvPolynomial.finSuccEquiv` を $d$ 段回せばよい。
仕分けの表は `outputs/reports/cycle29_ops_formalization_triage.md`。
この件数は `npm run check` の検査 F（`structured-latex/tools/verify-formalization-coverage.ts`）が
**毎回出す**ので、放置されれば見える。ブロック単位の台帳は
`structured-latex/tools/formalization-coverage.ts`、下の表は命題単位の詳細である。

判定語: **完了** / **部分的**（何が残っているか明記） / **未着手**（なぜかを一次情報で明記）。

| 命題 | 状態 | 内容 | 残り／理由 |
| --- | --- | --- | --- |
| **A**（$v_p$ の最終周期性） | **完了**（(1)(2)(3)）／(4) は非該当 | `exists_eventually_periodic_pow`（有限モノイドの鳩の巣）、`exists_eventually_periodic_matrixPow`、`exists_eventually_periodic_trace`、`exists_eventually_periodic_truncVal`、`exists_eventually_periodic_min_padicValInt` | (4)「有限手続きで決定可能」は計算可能性の主張であって命題ではないので Lean の定理にしていない |
| **L**（LTE, $P(z)=z-c$） | **完了**（4 分岐すべて） | `padicValNat_pow_sub_one_of_dvd`（$p\mid c$）、`padicValNat_pow_sub_one_of_not_dvd_order`（$d\nmid L$）、`padicValNat_pow_sub_one_odd`（$p$ 奇・$d\mid L$）、`padicValNat_two_pow_sub_one_odd_exp` / `..._even_exp`（$p=2$） | — |
| **V**（$\Lambda$ 側の非自明性判定） | **完了**（$d=1$ と $d=2$） | `X_pow_char_pow_sub_one`（核 $z^{p^n}-1=(z-1)^{p^n}$）、`resultant_X_pow_char_pow_sub_one`、`aOne_cast_zmod` / `dvd_aOne_iff`（$d=1$）、`aTwo_cast_zmod` / `dvd_aTwo_iff`（$d=2$） | 人手証明どおり $a_L$ を終結式で定義したまま形式化できた（mathlib の `Polynomial.resultant` を使用）。**「1 の冪根の上の積＝終結式」という claim の内容そのものは cycle 29 の `PeriodicPointResultant.lean` が入れた**（$d=1$: `resultant_X_pow_sub_one_eq_prod_eval`、$d=2$: `eval_innerRes` / `outerRes_eq_prod_prod_eval`、**一般の $d$**: `nestedRes_eq_tupleProd`）。$d\ge3$ に反復多項式環の新しい型は要らなかった（`MvPolynomial.finSuccEquiv` を $d$ 段回す） |
| **C**（Pisano 型上界） | **完了**（整除方向）／等号は非該当 | 代数的核（`PropC.lean`）: `dvd_one_add_pow_prime_sub_one`、`dvd_pow_prime_pow_sub_one`、`pow_prime_pow_eq_one_of_eq_one_add` / `matrix_pow_prime_pow_eq_one`。**周期そのもの**（`PropCPeriod.lean`）: `matrix_pow_mul_prime_pow_eq_one`、`orderOf_dvd_mul_prime_pow`、`orderOf_reduction_dvd`（＝$\pi(p,k)\mid\pi(p,1)p^{k-1}$）、純周期性の正当化 `isUnit_pow_add_eq_iff` / `isUnit_map_of_not_dvd_det`（$p\nmid\det T$） | 等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）は**人手証明のとおり一般には偽**（cycle 6 で六頂点 572 件中 4.5% の反例）なので形式化対象ではない。「最終周期の最小値」を `Nat.find` で定義する代わりに、可逆性から最終周期の条件が $A^t=1$ と同値であることを示して `orderOf` で述べた |
| **B**（$\pi(p,1)$ の精密公式） | **完了**（訂正後のステートメントについて等式・両方向）／原ステートメントは**偽** | `PropBTracePeriod.lean`: `eq_zero_of_expSum_pow_eq_zero`（指標の一次独立を Vandermonde で）、`expSum_eventually_periodic_iff`／`..._lcm_dvd`（$t$ が周期 $\iff\operatorname{lcm}\{\operatorname{ord}\lambda:m_\lambda\neq0\}\mid t$。**逆方向を含む**）、`isLeast_period_expSum`（最小周期＝lcm）、`trace_pow_eq_sum_maxGenEigenspace`（人手証明の第 1 段 $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$ を一般化固有空間分解から証明）、`trace_pow_eventually_periodic_iff`（代数閉体・固有値非零での仮定なし完成形）、`natCast_ne_zero_iff_not_dvd`（$m_\lambda\neq0$ in $K$ $\iff p\nmid m_\lambda$）。反例: `orderOf_cexMat`（$=3$）と `trace_cexMat_pow`（$\equiv0$） | **訂正**: 人手証明は $\pi(p,1)$ を命題 A の「行列冪列 $T^N\bmod p$ の最終周期」と書いているが、証明が計算しているのは「トレース列 $\operatorname{Tr}T^N\bmod p$ の最終周期」である。両者は一致せず（$4\times4$ の反例を Lean で形式化。ランダム標本 2487 例中 563 例＝22.6% で不一致）、**原ステートメントは偽**。トレース列の読みでは等式が両方向とも成り立つ。cycle 16 の「残るのは組み立てだけ」という記述もこの読み違いに基づいており、誤りだった。**未形式化**: 具体行列 $T\bmod p$ から $\overline{\mathbb{F}_p}$ への係数拡大の移送（数学的には自明だが Lean 内では未接続） |
| **N**（線形成長率＝Newton 多角形） | **部分的**（下界方向のみ）／本文を**訂正**した | `PropN.lean`: `trace_pow_add_eq_neg_sum`（Cayley–Hamilton 由来の線形漸化式）、`trace_pow_dvd_of_charpoly_coeff_dvd`（係数条件 $p^{m(d-i)}\mid c_i$ から $p^{mN}\mid p^{md}Z_N$。**固有値も Newton 多角形も $\mathbb{Q}_p$ も使わない**）、`le_padicValInt_trace_pow`（付値版）。反例: `trace_cexN_pow_odd` / `cexN_exceptional_unbounded` | **訂正**: 本文の「Skolem–Mahler–Lech 型の例外は**有限個の $N$**」は誤りで、例外集合は算術級数の有限和＝一般に**無限**（$T=(0\,1;2\,0)$, $p=2$ で全奇数 $N$ が例外）。根拠 report は「算術級数の有限和」と正しく書いていた。**未形式化**: 上界方向（SML / Strassmann が mathlib に無い）、鋭い下界（オフセット無し。Newton 恒等式の行列トレースへの接続が要る。恒等式自体は mathlib にある）、Newton 多角形と固有値の接続（$\overline{\mathbb{Q}_p}$ の付値が要る） |
| **T**（$v_2(\tau(L))=2(L-1)$） | **部分的**（代数的な段と算術の段）／本文に食い違いなし | `PropT.lean`: `prod_sub_pow_eq`、`prod_A_sub_zeta_eq`（人手証明 (3.1)）、`not_dvd_two_mul_of_odd` / `padicValNat_two_eq_zero_of_odd`（奇数性が効く 2 箇所）、`newton_two_root_valuations`（段 4 の組合せ核）、`v2_tau_eq_of_root_valuations`（段 5 の総和。外部依存を仮定として型に出した形） | **未形式化**: 段 1（matrix-tree。mathlib に全域木数の公式が**無い**）と段 3（2 の不分岐性と Hensel 持ち上げ。Hensel 自体は mathlib に**在る**が $\mathbb{Q}(\zeta_L)$ の完備化への配線が無い）。本文の数値（奇 $L$ の $2(L-1)$、偶 $L$ の $5,19,29,61,53,83,77$）は素の Python で独立に再計算して全一致 |
| **W**（非退化グラフ塔の閉形式） | **部分的**（判定条件のみ）／本文へ**帰属を追記**した | `PropW.lean`: `NoProjZero`（非退化性の定義と `Decidable` インスタンス）、`torus_nondegenerate_three` / `torus_degenerate_two`（本文の適用例 2 つを `decide` で検算）、`exists_proj_zero_of_linear`（非退化なら $k\ge2$）、`quintic_cubic_nondegenerate`、`propW_nu_not_integer_of_ell_five_k_three` | **追記**: 本文は $\nu$ の帰属を書いていなかったが、$\frac{k(\ell+1)}{\ell-1}$ は一般に非整数（$\ell=5,k=3$ で $9/2$。この $(\ell,k)$ は非退化性と両立する）なので $\nu\in\mathbb{Q}$ であって一般に $\mathbb{Z}$ ではない。**未形式化**: 閉形式本体。上界方向が Cuoco–Monsky に依拠し、岩澤型漸近は mathlib に無い（cycle 16・18 の grep で一致）。matrix-tree も要る |
| **J2 桁定理**（命題 J の (J1)(J1′)） | **完了**（桁定理本体・閾値の等式）／本文を**訂正**した | `DigitTheorem.lean`: `choose_cast_of_lt`（Lucas から出る $m<\ell^L$ の段）、`choose_cast_pow`（$\binom N{\ell^L}\equiv N/\ell^L$）、`choose_cast_pow_succ`、`Abar_shift`（**定理 J2 本体**）、`Abar_mod` / `Abar_congr`、`Abar_shift_pow_succ`（**命題 J2′ の等式本体**。右辺に $L$ が現れない＝「$L$ に依らない」）、`Bbar_diag`（$\bar B$ は $\bar A_2$ の極形式）、反例 `cexDigit_fails` | **訂正**: 本文 (J1) は $A_1\equiv0$ を仮定として書いていなかったが、$m=\ell^L$ ちょうどの段はこれなしでは**偽**（$\tilde E=z$, $\ell=3$, $L=1$）。本文へ仮定と反例を追記した。**未形式化**: 命題 J2′ の「破れる $\iff k=2$」（2 変数多項式としての $\bar A_2$ と $k=\mathrm{ord}(\bar g)$ の接続が要る。mathlib の欠落ではなく配線をしていない） |
| **X′**（bouquet 族の閉形式。命題 G′ の (G′3)） | **部分的**（場合分けの排反性・数え上げ・総和）／本文に食い違いなし | `BouquetClosedForm.lean`: `bouquet_cases_exclusive`（命題 8 の 3 つの場合が排反。$\ell$ の奇偶も素数性も使わない）、`card_diag_*` / `card_one_zero_*` / `card_generic_*`（レベル 1 の点の個数を `decide` で検算、$\ell=3,5,7$）、`card_diag_two`（**$\ell=2$ では $a\equiv b$ と $a\equiv-b$ が排反でない**）、`sum_level_A` / `sum_level_B`（**定理 X′ の総和**）、`ordKappa_of_sigma`、`theoremJ8_eq_XPrime` | **未形式化**: 塔の値 $\kappa_n$ の独立計算（matrix-tree。mathlib に全域木数の公式が**無い**）と、定理 X の付値計算（$\mathbb{Q}(\zeta_{\ell^m})$ への配線。円分体は mathlib に**在る**ので欠落ではない） |
| **J6・J7**（型 II / 型 III の判別。命題 J の (J4)） | **部分的**（総和・係数の取り出し）／本文に食い違いなし。**過剰仮定を 2 件検出** | `TowerTypeCoefficients.lean`: `sum_level_stab`（**定理 J6 の計算本体**）、`level_ratio_indep`（係数が $L$ に依らない）、`layer_sum`（**定理 J7 の層ごとの和**。$\varphi(\ell^{M'-1-v})\ell^{v+1}=\varphi(\ell^{M'})$ の相殺）、`sum_mul_pow`、`J8_direction_sum`、`sum_Theta_J8` / `ordKappa_J8`（定理 J8 の閉形式。step 2 の定理 X′ と独立に一致） | **過剰仮定**: (1) 定理 J6 の仮定 (ii)（$\theta^{\max}-2<\varphi(\ell^{n_1})$）は総和の段には効かない（効くのは $\hat\theta=\theta$ を出すところまで）、(2) 「係数が $L$ に依らない」は 2 つの比例関係だけから出る。**未形式化**: 定理 J7 の主張そのもの（$S_\infty$ と $j^*$ は $\mathbb{F}_\ell[[x]]$ の位数で定義される。`PowerSeries` / `PowerSeries.order` / 二項冪級数は mathlib に**在る**ので欠落ではなく配線） |
| **C′・C″**（トレース列の周期） | **部分的**（核と反例）／本文に食い違いなし | `PropCTracePeriod.lean`: `TraceOrth` / `IsTracePeriodAt`（周期の内容）、`traceOrth_of_forall_pow`（生成元の冪だけから全 $x$ へ）、`dvd_of_mulVec_dvd`（定理 6 の Smith 標準形の段を $HG=p^wI$ の形で）、`traceOrth_one_add_pow`（**定理 A′ の心臓部**）、`isTracePeriodAt_mul_prime`（$t_{k+1}\mid p\,t_k$）、反例 `lucas_two_power_not_period`（命題 12）・`trace_period_not_affine`（閉形式の不存在）。**cycle 29 が組み立てを足した**（`TracePeriodAssembly.lean`）: `dvd_of_isLeast_isPeriodMod`（最小周期は任意の周期を割る。人手証明が暗黙に使っていた一点）、`isTracePeriodAt_iterate` / `tracePeriod_dvd_pow_mul`（命題 C″ (2) 改良した上界）、`tracePeriod_propC_bound`（**命題 C′ の上界そのもの**）、`tThree_values`（本文の $t_k=1,2,2,4,8,16$）、`no_affine_trace_period_exponent`（**命題 C″ (4) 閉形式が存在しないことの主張そのもの**） | **食い違いは無かった**が、**過剰仮定を 2 件検出**: (1) 定理 A′ の証明に $p$ の素数性は要らない（効くのは $\binom{p}{1}=p$ だけ）、(2)「周期」の最小性も使っていない（最小性を仮定すると結論が述べられない）。**未形式化だった定理 W（＝本文の命題 W*）は cycle 28 で 3 段のうち 2 段が入った**（上の W\* の欄）。残るのは双対の段で、理由は変わらない——mathlib には `traceDual` / `differentIdeal` / `aeval_derivative_mem_differentIdeal` / `conductor_mul_differentIdeal` が**在る**（`logs/mathlib-gap-survey-cycle19.log`）。無いのは (a) 重み付きトレース形式の Gram 行列への配線と (b) **整数行列の単因子**（`Basis.SmithNormalForm` は部分加群の基底の形でしか無い）である |
| **L1**（桁枝再帰。打ち消しは起きない） | **部分的**（$s^*$ の存在・枝分解・係数の取り出し・上界の達成）／本文に食い違いなし。**過剰仮定を 2 件検出** | `DigitBranchRecursion.lean`: `sigma_eq_of_max`（定理 L1 の 2 の核）、`exists_sigma_ne_zero_lt`、`one_add_X_pow_split` / `branch_decomposition`（補題 L0）、`coeff_branch_single` / `coeff_branch_sum`（$(2.1)$）、`coeff_branch_lt`、`exists_coeff_ne_zero_of_branches`（打ち消しでは消えない）、`L1_bound`、`geom_sum_one_add_X_pow_char`（系 L2 の上界の達成） | **過剰仮定**: (1) $s^*$ の存在に行列 $\bigl(\binom cs\bigr)$ の可逆性は要らず、$C$ の最大元 1 つで済む（$\ell$ の素数性も体であることも不要。上界も $s^*\le\max C$ と鋭い）、(2) $(2.1)$ に $c<\ell$ は不要。**未形式化**: $\mathbb{Z}_\ell$ 指数版（`PowerSeries` と二項冪級数は mathlib に**在る**ので配線）、$\mathrm{sep}$ についての帰納法そのもの |
| **W3・W4・W6**（$S_\infty$ の判定手続きと $j^*$） | **部分的**（判定の決定可能性・(iii)⇒(iv)・実例）／本文の記述に 2 点の問題 | `SInfinityDecision.lean`: `bucketVanish_iff` / `decidableBucketVanish`（**有限手続きであることを型に出した**）、`psiHom` / `psi_coeff`、`psi_chi_perp_sub_one` / `psi_eq_zero_of_dvd`（補題 W2 の (iii)⇒(iv)）、`torus_Sinf_candidates`（$\ell=2$ トーラスで $S_\infty$ を `decide`）、`fam3_Sinf_singleton`（**$|S_\infty|=1$ なのに $b=2$**） | **本文への申し送り**: (K3) の出力は点集合までで $b$ には (K4) の重複度が要る／(K2) の (iv) の $\gamma$ の走査範囲が有限であることが書かれていない。**未形式化**: (iv)⇒(iii)（$\ker\bar\psi_u$ の同定）と定理 W4 の $e_j$ 側は**配線**。系 W7 は Newton **多面体**が mathlib に**無い** |
| **Q1**（(B\*) 無しの $n\ell^n$ 係数） | **部分的**（組合せ・数え上げ・最小点の一意性・誤差の組み立て）／本文（report）の記述に **3 点の問題** | `DropAssumptionBStar.lean`: `unique_min_of_val_seq`（補題 Q2 (2) の核。仮定は $\theta_G<\varphi(\ell^M)$ **だけ**）、`BG_dominates`（定理 Q4 の比較）、`totient_pow_mul_pow` / `sum_totient_pow` / `layer_card_sum`（層分解が**分割**であることの照合）、`lemma_Q3`（**補題 Q3 の等式**）、`lemma_Q3_old_formula_false`（初稿の式が偽であることの反例）、`lemma_Q3_diff`、`lemma_Q5_rho_max` / `lemma_Q5_needs_strict`（$c_1$ に**狭義**不等式が要ること）、`lemma_Q5_card`、`theorem_Q1_error` / `theorem_Q1_error_explicit`（$(6.1)$ の三角不等式） | **申し送り 3 件**: (1) $(6.1)$ の「明示定数 $C$」は $|\mathcal{B}_M|$ を含むので $M$ 依存であり、補題 Q5 の上界 $r\ell^{c_1}$ を代入した形に直すべき、(2) 補題 Q5 に必要なのは狭義不等式で、$c_1$ の $+1$ がそこに効いている（この根拠が本文に無い）、(3) 補題 Q0 の適用に要る $\tilde E(\omega_P)\ne0$ が定理 Q1 の証明で明示されていない。**未形式化**: 補題 Q4a（円分体の付値）・補題 Q1′（2 変数 Laurent 環の UFD）・補題 Q0（アルキメデス評価）はいずれも**配線**（下の cycle22 調査） |
| **G1–G4**（一般の塔の閉形式） | **部分的**（5 係数の代数・最小点の一意性・$K$ の算術）／**内部の食い違い 1 件・根拠の欠落 1 件を検出** | `GeneralTowerClosedForm.lean`: `S0_closed` / `S1_closed` / `S0_decomp` / `S1_decomp`、`theorem_G1`（**$(2.2)$$(2.3)$ の 5 係数すべて**を恒等式として検算）、`theorem_G1_remark_2_2`、`theorem_G1_e_indep`、`twisted_unique_min` / `twisted_unique_min_k_zero`（**定理 G2 の 2**）、`K_wellDefined` / `K_zero_iff` / `K_ge_one_of_ell_two` / `K_ge_one_of_jstar_large` / `K_example_ell_three`（**定理 G3**）、`G3_positivity`、`G3_two_levels`（$(4.2)$ が 2 レベルから決まること）、`sum_totient_Ico` / `layer_b_boundary`、`theorem_G4_b` / `theorem_G4_c`（$(5.5)$）、`G4_K_dependence` | **食い違い**: §5.3 の $M^*$ の条件 2（$M\ge r^\sharp+\max K+1$）は 1 つ強く、(b) の層の閉形式に要るのは $M\ge r^\sharp+K$ である。実際 §6.1 は $M^*=1=r^\sharp+K$ を使っており条件 2 を満たしていない。**直すべきは条件 2**。**根拠の欠落**: 注 4.2（$K$ は上界でよい）は正しいが、その理由（$K\to K+1$ で $(5.3)$$(5.4)$ の変化が打ち消し合う）が書かれていない。**未形式化**: 定理 G2 の 1・3（円分体の Galois 不変性と剰余体。**配線**）、$A_{\mathrm{gen}}$ の $L$ 非依存性（射影直線のレベル構造。**配線**）、$\kappa_n$ の独立計算（**Matrix–Tree は mathlib に無い**。Lean 外で照合） |
| **Y′・Y″**（$\ell=2$ の族の閉形式） | **部分的**（閉形式の形・場合分け・$n=1$ の但し書き）／**主張の欠陥を 1 件・根拠不足を 1 件検出** | `EllTwoClosedForm.lean`: 4 行の閉形式と数列（`Aalpha_seq` 他）、`caseA_or_caseB` / `not_caseA_and_caseB`（排反・網羅）、`Bsat_ne_B_at_one`（但し書きが必要な場合）、`Aalpha_one_eq_B_one` / `Abeta_one_eq_B_one`（但し書きが冗長な場合）、`Aalpha_eq_Xprime_at_one_two` / `Aalpha_ne_Xprime_at_three`（系 Y″ の 2 点論法への反例） | **欠陥**: $(5.4)$ 第 3 行の「および全ての場合の $n=1$」は case A で $\lambda_1$ が未定義なので読めない。必要なのは case B・$\lambda_1=1$ の $n=1$ だけ。**根拠不足**: 系 Y″ の「$n=1,2$ の 2 点で既に食い違う」は $\Lambda$ を動かすと偽（A$\alpha$ は $\Lambda=1$ と $n=1,2$ で一致し $n=3$ で分かれる）。**未形式化**: $(5.4)$ の導出（円分体への配線）と塔の値（matrix-tree は mathlib に**無い**ので Lean 外で照合した） |
| **M**（本文の命題 M。一般の塔の閉形式） | **部分的**（(M1) の規約・(M2) の $\lambda$・(M3) の $A_\mathrm{gen}$ の $L$ 非依存性・(M5) の条件 2 と条件 4・(M6)）／**本文と根拠 report の食い違いは検出されなかった** | `Cycle25Corrections.lean`: `M2_lambda_eq_ceil_logb`（本文の括弧書き「値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」）、`sum_of_uniform_fibers` / `Agen_level_indep`（(M3) の $L$ 非依存性）、`G2_minEmpty_*` / `G2_top_reading_ok_at_ell_three`（(M1) の規約が無いと $\ell=3$ が落ちること）。`Cycle24Corrections.lean`: `G4_cond2_corrected_at_61` / `G4_cond_all_at_61` / `corollary_G6` | **未形式化**: (M1) の Galois 不変性と $\varphi(\ell^{k})\Lambda_k\in\mathbb{Z}_{\ge1}$（円分体の分岐と剰余体への**配線**）、$\tilde E$ そのもの（**Matrix–Tree が mathlib に無い**） |
| **U**（本文の命題 U。係数の情報階層） | **部分的**（(U1) の $c$・$d$ が (M3)+(M4) から出ること、(U2) の $T_\mathrm{def}$ と (M4) の角括弧の一致、(U4) の数値、(U6) の切り捨て付値列）／**本文と根拠 report の食い違いは検出されなかった** | `Cycle25Corrections.lean`: `U1_c_from_M3_M4` / `U1_d_from_M3_M4` / `U2_bracket_eq_Tdef` / `U4_c_at_ell_two` / `U4_d_at_ell_two` / `U4_p_one_values` / `U4_p_three_values` / `U4_c_same_d_differs` / `U6_trunc_determines_stage_data` | **未形式化**: (U4)(U5) の塔から $\tilde E$ を作る段（Matrix–Tree）、(U6) の「$\tilde E\bmod\ell^{N}$ が切り捨て付値列を決める」側（$\mathcal{O}_k$ 係数の線形性の**配線**）。**射程の限定**: `U6_trunc_determines_stage_data` は付値が**整数値**（$k=0$）の場合であり、$\Lambda_k=j^{*}/\varphi(\ell^{k})$ が非整数になる一般の $k$ は含まない |
| **W\***（$w^*$ の代数的閉形式） | **部分的**（微分の段と付値の段。3 段のうち 2 段）／本文に食い違いなし。**過剰仮定を 1 件検出** | `PropWStarDifferent.lean`: `derivative_prod_pow`（$\chi=\prod_i f_i^{a_i}$ のとき $\chi'=h\cdot\sum_i a_i f_i'(\rho/f_i)$。「$\chi'/h\in\mathbb{Z}[x]$」を割り算ではなく積の形で述べたので商体へ出ない）、`ceilDivNat` / `ceilDivNat_le_iff`（切り上げ除算の特徴づけ）、`isLeast_wStar`（$\min\{j:\forall\mathfrak p,\ j\,e_\mathfrak p\ge v_\mathfrak p\}=\max_\mathfrak p\lceil v_\mathfrak p/e_\mathfrak p\rceil$）、`wStar_eq_zero_of_unramified` / `wStar_le_of_tame`（本文の 2 つの但し書き） | **過剰仮定**: 微分の段に $f_i$ の既約性も相異性も要らない（効くのは $a_i\ge1$ だけで、任意の可換環の任意の族で成り立つ）。既約性が要るのは $\rho=\mathrm{rad}(\chi)$ と名乗る段と $\rho$ の分離性である。**本文の「この切り上げは実数の切り上げではない」は型でそのまま出た**（$\mathbb{N}$ の除算ひとつ。$\mathbb{R}$ も $\mathbb{Q}$ も現れない）。**未形式化**: 双対の段（$A^\vee=\rho'(\theta)^{-1}A$ から $\operatorname{coker}(G)\cong A/\eta A$ へ）。理由は下の C′・C″ の欄と同じで、`traceDual` / `differentIdeal` は**在る**が Gram 行列の最大単因子への配線と整数行列の Smith 標準形が無い |
| **F**（有限台なら $\lambda$ が計算できる） | **部分的**（(F1) の心臓部）／本文に食い違いなし。**過剰仮定を 1 件検出** | `PropFFiniteSupport.lean`: `exists_ne_of_fibers_sum_eq_zero`（**すべてのファイバーの係数和が消えるなら分類写像は台の上で単射でない**＝人手証明の「各 $c_e\ne0$ なので、割るにはどのファイバーも 2 点以上でなければならない」）、`vecGcd` / `prim` / `isUnit_vecGcd_prim`（原始化と、方向が単元倍を除いて一意なこと）、`directions` / `mem_directions_of_fibers_sum_eq_zero`（**割りうる方向は有限集合 $V(E)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$ に入る**＝非可算な $\mathbb{P}^{d-1}(\mathbb{Z}_p)$ を走らなくてよいことの中身） | **過剰仮定**: この段に体であることも標数 $p$ であることも要らない（係数は任意の可換群でよい）。**未形式化**: (1) $(\gamma_v-1)\mid\bar f$ と係数和の消滅の**同値そのもの**。$d$ 変数の完備群環 $\mathbb{F}_p[[\Gamma]]$ とその素イデアルの記述が要るが、mathlib には岩澤代数の一般論が `PowerSeries` の断片としてしか無い（**配線ではなく素材から要る**）。(2) (F2 境界) の停止問題への帰着。`Nat.Partrec` / `Turing` は**在る**が、「係数を計算する手続きで与えられた $f$」という入力の与え方を型にする設計をこちらが持っていない（**mathlib の欠落ではなくこちらの未設計**） |
| **双対命題 D**（同一の整数曲線の二素点） | **部分的**（$p$ 素点・有限の $L$ の段を $d=1$ で）／本文に食い違いなし | `DualityPAdicFiniteL.lean`: 簡約周期点数 $a^{\mathrm{red}}_L=\prod_{\zeta^L=1,\ P(\zeta)\neq0}P(\zeta)$ の**定義そのもの**（Lean のどこにも無かった。既存の `PropV.lean` と `PeriodicPointResultant.lean` は簡約しない $a_L$ だけを扱う）、$a^{\mathrm{red}}_L\neq0$、$a^{\mathrm{red}}_L=\mathrm{Res}(h,P)$（$h$ は $X^L-1$ の monic な因子）、$h=(X^L-1)/\gcd(X^L-1,P)\in\mathbb{Z}[X]$（Gauss）、$h$ の根がちょうど本文の「良い根」であること | **切り出せたのは 3 段のうち 1 段だけ**である。**アルキメデス側**（自由エネルギー密度＝Mahler 測度）は命題 LSW と同じ理由で素材が無い（多変数の Mahler 測度が無い）。**塔の漸近**は Monsky / Cuoco–Monsky の適用で、3 段の走査で `Monsky` / `CuocoMonsky` / `semialgebraic` / $\mathbb{Z}_p^d$ 拡大が**すべて 0 件**（`logs/mathlib-gap-survey-cycle29-duality.log`）。$d\ge2$ について、step 2 が挙げた「反復多項式環の型」という壁は step 3b で消えた（`nestedRes` が一般の $d$ で書けている）。ただし簡約周期点数は $P$ が消える組だけを除く量で、その除去は変数ごとに剥がす形にならない。**そこをどう書くかは未着手であり、書けるかどうかを確かめてもいない。** **本文は後 2 段を証明せず外部定理を引用している** |
| **Q1 の $c_1$**（訂正後） | **完了**（新定義の存在・一意性・$b=0$・新旧の大小・中間段） | `Cycle25Corrections.lean`: `Q5_c1_isLeast` / `Q5_c1_unique` / `Q5_c1_zero_of_b_zero` / `Q5_c1_table_check` / `Q5_old_junk_not_least` / `Q5_rho_max_of_isLeast` / `Q5_case_split` / `Q5_c1_new_le_old` / `Q1_C_at_b_zero` / `Q1_b_zero_matches_layer_count` | 補題 Q5 の**結論**（$\mathcal{B}_M$ の被覆による個数評価）は cycle 22 の `lemma_Q5_card` が既に型に出している。$\theta_G^{\max}$ の有効上界は未形式化（実測に依存） |

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
| `logs/build-cycle20-J.log` | cycle 20 step 4 の `lake build`。末尾 `Build completed successfully (8671 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle20.log` | cycle 20 step 4 の `scripts/check-no-sorry.sh`。列挙した **156 個**の定理はいずれも `sorryAx` 非依存 / `CHECK_EXIT=0` |
| `logs/cache-get-cycle20.log` | cycle 20 の `lake exe cache get` / `CACHE_EXIT=0` |
| `logs/mathlib-gap-survey-cycle20.log` | cycle 20 の欠落調査（3 段方式）。Lucas の定理・`add_pow_char`・`coeff_one_add_X_pow`・Kummer を検索語にした版。**`Mathlib/Data/Nat/Choose/Lucas.lean` は実在する**ことを確認した記録（`Choose.choose_modEq_choose_mul_prod_range_choose` を実際に使用） |
| `logs/mathlib-gap-survey-cycle19.log` | cycle 19 の欠落調査（3 段方式）。`traceDual` / `differentIdeal` / Smith 標準形 / Lucas 数を検索語にした版。**`traceDual` と `differentIdeal` は実在する**ことを確認した記録 |
| `logs/build-cycle21-L1WY.log` | cycle 21 step 3 の `lake build`。末尾 `Build completed successfully (8674 jobs).` / `BUILD_EXIT=0` |
| `logs/check-no-sorry-cycle21.log` | cycle 21 step 3 の `scripts/check-no-sorry.sh`。列挙した **196 個**の定理はいずれも `sorryAx` 非依存 / `CHECK_EXIT=0` |
| `logs/cache-get-cycle21.log` | cycle 21 の `lake exe cache get` / `CACHE_EXIT=0` |
| `logs/mathlib-gap-survey-cycle21.log` | cycle 21 の欠落調査（3 段方式）。Kirchhoff / 全域木数 / Newton **多面体** / 格子周長を検索語にした版。**Newton 多面体は無い**（語幹 `newton` の 7 ファイルはすべて Newton–Raphson・Newton 恒等式）ことと、`Polynomial.resultant` / `IsCyclotomicExtension` / `AddMonoidAlgebra.mapDomain_mul` が**実在する**ことを確認した記録。末尾に「3 段目でフレーズをファイル名検索してしまい取り直した」ことを明記 |
| `logs/build-cycle22-Q1G4.log` | cycle 22 step 4 の `lake build`。末尾 `Build completed successfully (8676 jobs).` / `BUILD_EXIT=0`（cycle 21 の 8674 に新規 2 モジュールを足した数と一致し、**cycle 21 step 3 の 8674 jobs を独立に再現している**） |
| `logs/check-no-sorry-cycle22.log` | cycle 22 step 4 の `scripts/check-no-sorry.sh`。列挙した **231 個**（cycle 21 は 196 個。今回 **35 個**追加）の定理はいずれも `sorryAx` 非依存 / `CHECK_EXIT=0`。内訳は依存公理 `[propext, Classical.choice, Quot.sound]` が 175、`[propext, Quot.sound]` が 28、`[propext]` が 25、公理なしが 3 |
| `logs/cache-get-cycle22.log` | cycle 22 の `lake exe cache get`。末尾 `Completed successfully in 66601 ms!` / `CACHE_EXIT=0` |
| `logs/mathlib-gap-survey-cycle22.log` | cycle 22 の欠落調査（3 段方式 + targeted 追加）。円分体の分岐・Laurent 環・射影直線・Matrix–Tree・Newton 多面体を検索語にした版。**`IsTotallyRamified` が 3 段とも 0 件だったのは語の選び方の問題**であり、`ramificationIdx`（16 件）/ `inertiaDeg`（15 件）で表現されている（＝欠落ではない）ことを追加確認した記録。**2 変数 Laurent 環の型は無い**（1 変数は在る）ことと、**Matrix–Tree・Newton 多面体は無い**ことを再確認 |
| `logs/ell2-matrix-tree-cycle21.log` | 定理 Y′ の独立検証（`scripts/ell2-matrix-tree-cycle21.py`）。Matrix–Tree 定理＋Bareiss 法の整数計算で $\kappa_n$ を出し $(5.4)$ と照合。12 塔 × $n\le4$ ＝ **48 件、FAIL 0** |
| `logs/build-cycle24.log` | cycle 24 step 5 の `lake build`。末尾 `Build completed successfully (8678 jobs).` |
| `logs/check-no-sorry-cycle24.log` | cycle 24 step 5 の `scripts/check-no-sorry.sh`。列挙した **294 個**の定理はいずれも `sorryAx` 非依存 |
| `logs/build-cycle25.log` | cycle 25 step 3 の `lake build`。末尾 `Build completed successfully (8679 jobs).` / `EXIT=0`（cycle 24 の 8678 ＋ 新規 1 モジュール） |
| `logs/check-no-sorry-cycle25.log` | cycle 25 step 3 の `scripts/check-no-sorry.sh`。列挙した **327 個**（cycle 24 は 294 個。今回 **33 個**追加）の定理はいずれも `sorryAx` 非依存 / `EXIT=0` |
| `logs/mathlib-gap-survey-cycle29.log` | cycle 29 step 1 の欠落調査（3 段方式）。matrix-tree / 全域木数 / 多変数 Mahler 測度 / SML / Strassmann / Newton 多面体 / 岩澤不変量 / **整数行列の Smith 標準形**を「無いはず」側、終結式 / 円分拡大 / Hensel / `traceDual` / `differentIdeal` / `PowerSeries.order` / `Nat.Partrec` / `ramificationIdx` を「在るはず」側として引いた版。**Smith 標準形の語幹ヒット 3 件はすべて `Module.Basis.SmithNormalForm`（部分加群の基底の形）で、行列の単因子ではない**ことと、**2 つの Mahler 測度ファイルが `MvPolynomial` を 1 度も使っていない**ことを再確認した |
| `logs/cache-get-cycle25.log` | cycle 25 の `lake exe cache get`（worktree は依存が未取得）。末尾 `Completed successfully in 73598 ms!` / `EXIT=0` |
