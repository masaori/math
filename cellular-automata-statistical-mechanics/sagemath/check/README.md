# sagemath/check — 種の検算

各検算は `<対象名>/` に置き、`overview.md` に**対象ラベル**（どの種・どの命題を検証するか）を宣言する。
規約はリポジトリ共通（[CLAUDE.md](../../../CLAUDE.md) のプロジェクトテンプレート）。

## 実施済みの検算

| ディレクトリ | 対象 | 結果 |
|---|---|---|
| [`clifford_matrix_tower/`](clifford_matrix_tower/) | $\mathrm{Cl}_{2n}(\mathbb{C})\cong M_{2^n}(\mathbb{C})$（Jordan–Wigner 生成元、$n=1,2,3$） | **合致**。$\mathbb{R}$ 脱出なし |
| [`essential-dependency-support/`](essential-dependency-support/) | 本質的依存と一点反転検査の同値、および依存台の有限走査 | 実行結果は各 `overview.md` を正本とする |
| [`redundant-neighbor-independence/`](redundant-neighbor-independence/) | 冗長拡大による追加元への非依存、依存の移送、本質的依存台の不変性 | 実行結果は各 `overview.md` を正本とする |
| [`time-expansion-dependency/`](time-expansion-dependency/) | 大域写像の一点反転、イベント集合、一段依存関係、時刻増加 | 実行結果は各 `overview.md` を正本とする |
| [`finite-propagation-boundary/`](finite-propagation-boundary/) | 経路の時刻差、伝播球、依存元集合の有限伝播境界 | 実行結果は各 `overview.md` を正本とする |

## 予定されている検算（未着手）

| ディレクトリ | 対象 | 出典 |
|---|---|---|
| `rule_invariants/` | **第一相の総当たり**: 初等 CA 256 個 × 保存量・$Z_N$・ゼータ関数・次元群・Bowen–Franks 群・線形性・可逆性。識別力も測る | [CAから出発する代数構造の探索](../../docs/survey/CAから出発する代数構造の探索.md) 「次にやること」節 |
| `lambda_thermodynamics/` | 種「Λ値熱力学の構成」: 加法的保存量 → $\Omega\in\mathbb{N}$ → $S,\beta\in\Lambda$ → 第〇法則 | [ideas 一覧](../../docs/ideas/アイディアの種_一覧.md) 種「Λ値熱力学の構成」 |
| `phi_support/` | 種「Φ_N の台と代数的複雑度」: $\Phi_N$ の台。初等 CA 256 個 × $L$ × $N$ | [ideas/01](../../docs/ideas/種_Φ_Nの台と代数的複雑度.md) 「最初の検算（`sagemath/check/phi_support/` に置く）」節 |
| `ledrappier_padic/` | 種「線形CAとMahler測度」: Ledrappier three-dot の三素点突き合わせ | [ideas/02](../../docs/ideas/種_線形CAとMahler測度.md) 「最初の検算（`sagemath/check/ledrappier_padic/`）」節 |
| `lambda_invariants/` | 種「Λ値不変量の三つの顔」: $\log\operatorname{ind}$ / $h$ / $M$ の比較表 | [ideas/03](../../docs/ideas/種_Λ値不変量の三つの顔.md) 「最初の検算」節 |
| `finite_predicates/` | 種「可解性は有限検査で決まる」: 線形性・可逆性・保存量の総当たり | [ideas/00](../../docs/ideas/アイディアの種_一覧.md) 種「可解性は有限検査で決まる」 |

## 検算の原則

- **厳密計算のみ**。$\mathbb{Z}$/$\mathbb{Q}$/$\overline{\mathbb{Q}}$（`ZZ`/`QQ`/`QQbar`）と素因数分解で行い、
  浮動小数点は使わない。$\mathbb{R}$ を使う箇所（Mahler 測度の数値評価など）は
  **その旨を `overview.md` に種類つきで明記する。**
- 結果は `overview.md` に、実行ステータス・入力・出力・結論の順で記録する。
- 仮説が**否定された場合も必ず記録する**（種の「潰れ方」の欄を更新する）。
