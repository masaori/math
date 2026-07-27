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

## 形式化の現状

判定語: **完了** / **部分的**（何が残っているか明記） / **未着手**（なぜかを一次情報で明記）。

| 命題 | 状態 | 内容 | 残り／理由 |
| --- | --- | --- | --- |
| **A**（$v_p$ の最終周期性） | **完了**（(1)(2)(3)）／(4) は非該当 | `exists_eventually_periodic_pow`（有限モノイドの鳩の巣）、`exists_eventually_periodic_matrixPow`、`exists_eventually_periodic_trace`、`exists_eventually_periodic_truncVal`、`exists_eventually_periodic_min_padicValInt` | (4)「有限手続きで決定可能」は計算可能性の主張であって命題ではないので Lean の定理にしていない |
| **L**（LTE, $P(z)=z-c$） | **完了**（4 分岐すべて） | `padicValNat_pow_sub_one_of_dvd`（$p\mid c$）、`padicValNat_pow_sub_one_of_not_dvd_order`（$d\nmid L$）、`padicValNat_pow_sub_one_odd`（$p$ 奇・$d\mid L$）、`padicValNat_two_pow_sub_one_odd_exp` / `..._even_exp`（$p=2$） | — |
| **V**（$\Lambda$ 側の非自明性判定） | **完了**（$d=1$ と $d=2$） | `X_pow_char_pow_sub_one`（核 $z^{p^n}-1=(z-1)^{p^n}$）、`resultant_X_pow_char_pow_sub_one`、`aOne_cast_zmod` / `dvd_aOne_iff`（$d=1$）、`aTwo_cast_zmod` / `dvd_aTwo_iff`（$d=2$） | 人手証明どおり $a_L$ を終結式で定義したまま形式化できた（mathlib の `Polynomial.resultant` を使用）。$d\ge3$ は同じ補題の反復で出るが未記述 |
| **C**（Pisano 型上界） | **部分的** | 代数的核を証明: `dvd_one_add_pow_prime_sub_one`（二項展開の 1 段）、`dvd_pow_prime_pow_sub_one`（反復）、`pow_prime_pow_eq_one_of_eq_one_add` / `matrix_pow_prime_pow_eq_one`（$U\equiv I \bmod p \Rightarrow U^{p^{k-1}}=I$） | **残り**: $\pi(p,k)$ を「最終周期の最小値」として定義し、$p\nmid\det T$ から純周期性（最終周期＝`orderOf`）を出して $\pi(p,k)\mid p^{k-1}\pi(p,1)$ を結論する段。最小周期の定義と純周期性の補題群が未整備で、核の証明とは独立の作業量がある |
| **B**（$\pi(p,1)$ の精密公式） | **未着手** | — | $\overline{\mathbb{F}_p}$ 上での $\chi_T$ の相異固有値・代数的重複度 $m_\lambda$ の取り出しと、指標の一次独立性が要る。mathlib には固有値の重複度を $\overline{\mathbb{F}_p}$ 上で扱う直接の API が無く、`Polynomial.roots` と分解体を自前で組む必要がある。核（有限体の乗法的位数の lcm）だけを切り出しても人手証明の主張にならないので、部分形式化の価値が薄いと判断した |
| **N**（線形成長率＝Newton 多角形） | **未着手** | — | **mathlib に $p$ 進 Newton 多角形が無い**。mathlib commit `520045ab14e2` に対する grep で `newtonPolygon` / `NewtonPolygon` のヒットが **0 件**（`logs/mathlib-gap-survey.log`）。整数点の下方凸包とその傾きが付値に対応するという定理を一から作る必要がある |
| **T**（$v_2(\tau(L))=2(L-1)$） | **未着手** | — | **mathlib に Kirchhoff の matrix-tree 定理（全域木数）が無い**。同 grep で `Kirchhoff` / `matrixTree` / `matrix-tree` / `numSpanningTrees` がいずれも **0 件**。加えて人手証明（`cycle13_T1_observation_T_settlement.md` §3）は $\mathbb{Q}(\zeta_L)$ の素イデアル分解・Hensel の補題・Newton 多角形を使うので、上の N の欠落もそのまま効く |
| **W**（非退化グラフ塔の閉形式） | **未着手** | — | 人手証明自身が外部定理に依拠している。`cycle14_T3_two_variable_criterion.md` §0 が「$a\le v_\ell(\mathrm{content})$（上界方向）は**自前では証明できなかった**、Cuoco–Monsky の $m_0$ 不変量の定理そのものである」と明記している。その Cuoco–Monsky／岩澤型漸近は mathlib に無い（同 grep で `Iwasawa invariant` / `mu invariant` が **0 件**）。matrix-tree 定理も要る（上記 T と同じ理由）。なお **Weierstrass 準備定理は mathlib にある**（`Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean`、完備局所環上の冪級数版）ので、W の障害は準備定理ではなく岩澤型漸近と matrix-tree の側である |

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
| `logs/mathlib-gap-survey.log` | 未形式化命題の理由づけに使った mathlib の grep 結果（mathlib commit つき） |
