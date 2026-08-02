# sagemath/check — 種の検算

各検算は `<対象名>/` に置き、`overview.md` に**対象ラベル**（どの種・どの命題を検証するか）を宣言する。
規約はリポジトリ共通（[CLAUDE.md](../../../CLAUDE.md) のプロジェクトテンプレート）。

## 予定されている検算（未着手）

| ディレクトリ | 対象 | 出典 |
|---|---|---|
| `phi_support/` | 種「Φ_N の台と代数的複雑度」: $\Phi_N$ の台。初等 CA 256 個 × $L$ × $N$ | [ideas/01](../../docs/ideas/種_Φ_Nの台と代数的複雑度.md) 「最初の検算（`sagemath/check/phi_support/` に置く）」節 |
| `ledrappier_padic/` | 種「線形CAとMahler測度」: Ledrappier three-dot の三素点突き合わせ | [ideas/02](../../docs/ideas/種_線形CAとMahler測度.md) 「最初の検算（`sagemath/check/ledrappier_padic/`）」節 |
| `lambda_invariants/` | 種「Λ値不変量の三つの顔」: $\log\operatorname{ind}$ / $h$ / $M$ の比較表 | [ideas/03](../../docs/ideas/種_Λ値不変量の三つの顔.md) 「最初の検算」節 |
| `finite_predicates/` | 種「可解性は有限検査で決まる」: 線形性・可逆性・保存量の総当たり | [ideas/00](../../docs/ideas/アイディアの種_一覧.md) 種「可解性は有限検査で決まる」 |

## 検算の原則（`docs/context/` より）

- **厳密計算のみ**。$\mathbb{Z}$/$\mathbb{Q}$/$\overline{\mathbb{Q}}$（`ZZ`/`QQ`/`QQbar`）と素因数分解で行い、
  浮動小数点は使わない。$\mathbb{R}$ を使う箇所（Mahler 測度の数値評価など）は
  **その旨を `overview.md` に型（「実現の脱出」–「完備性」）つきで明記する。**
- 結果は `overview.md` に、実行ステータス・入力・出力・結論の順で記録する。
- 仮説が**否定された場合も必ず記録する**（種の「潰れ方」の欄を更新する）。
