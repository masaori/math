# sagemath/check — 種の検算

各検算は `<NNN>_<対象>/` に置き、`overview.md` に**対象ラベル**（どの種・どの命題を検証するか）を宣言する。
規約はリポジトリ共通（[CLAUDE.md](../../../CLAUDE.md) のプロジェクトテンプレート）。

## 予定されている検算（未着手）

| ディレクトリ | 対象 | 出典 |
|---|---|---|
| `001_phi_support/` | 種 S6: $\Phi_N$ の台。初等 CA 256 個 × $L$ × $N$ | [ideas/01](../../docs/ideas/01_種S6_Φ_Nの台と代数的複雑度.md) §5 |
| `002_ledrappier_padic/` | 種 S2: Ledrappier three-dot の三素点突き合わせ | [ideas/02](../../docs/ideas/02_種S2_線形CAとMahler測度.md) §4 |
| `003_lambda_invariants/` | 種 S1: $\log\operatorname{ind}$ / $h$ / $M$ の比較表 | [ideas/03](../../docs/ideas/03_種S1_Λ値不変量の三つの顔.md) §5 |
| `004_finite_predicates/` | 種 S5: 線形性・可逆性・保存量の総当たり | [ideas/00](../../docs/ideas/00_アイディアの種_一覧.md) S5 |

## 検算の原則（`docs/context/` より）

- **厳密計算のみ**。$\mathbb{Z}$/$\mathbb{Q}$/$\overline{\mathbb{Q}}$（`ZZ`/`QQ`/`QQbar`）と素因数分解で行い、
  浮動小数点は使わない。$\mathbb{R}$ を使う箇所（Mahler 測度の数値評価など）は
  **その旨を `overview.md` に型（E1–E4）つきで明記する。**
- 結果は `overview.md` に、実行ステータス・入力・出力・結論の順で記録する。
- 仮説が**否定された場合も必ず記録する**（種の「潰れ方」の欄を更新する）。
