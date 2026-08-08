# MEMORY — 2次元 Ising 模型の厳密解（Λ・Fisher 零点の立場）

作業前に [README.md](README.md) と リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと。

## 現在の到達点（2026-08-08 時点）

雛形を作り、章「分配多項式」の入口まで書いた。

| 層 | 状態 |
| --- | --- |
| 記述（構造化テキスト） | 章「分配多項式」の定義 4 件・主張 1 件・注意 1 件。`npm run check` 全通過 |
| SageMath 検証 | `partition-polynomial-coefficient-sum` を実行済み（$L=1,2,3$ で成立、厳密計算） |
| Lean 具体版 | **未着手**（空の名前空間のみ。ただし環境は整っており `lake build` は通る） |
| Lean 必要十分版 | **未着手** |

Lean の環境は 2026-08-08 に整えた。`lake update` → `lake exe cache get` → `lake build` が通り、
mathlib の実体は `lean/lake-manifest.json` で固定してある（`.lake/` は git 管理外）。
詳細は [lean/README.md](lean/README.md)。

書いた内容は、格子・配位・破れボンド数・多重度・分配多項式 $Z_L(x)\in\mathbb{Z}[x]$ の定義と、
「多重度の総和は配位の総数に等しい」（$\sum_m\Omega_L(m)=2^{L^2}$）の証明である。
この範囲に $\mathbb{R}/\mathbb{C}$ は現れない。

## 進め方（自動ループ）

このプロジェクトは **1 時間に 1 回の自動ループ**で進む。手順の正本は
[docs/tasks/auto-loop-runbook.md](docs/tasks/auto-loop-runbook.md)、進捗の正本は
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) である（このファイルではない）。

- 1 tick = 既存出力のレビューと修正 → セクションを **1 つだけ** 前進 → 検証 → push → 停止。
- 各 tick は launchd（`com.masaori.ising-lambda-auto-loop`）が起動する
  **独立した Claude セッション**で走る。会話の文脈は持ち越さない。
- 次に何をするかは、下の「次回やること」ではなく**状態台帳のセクション表**を見る。

## 次回やること

1. **`claim_coefficient_sum` を Lean で形式化する**（具体版・必要十分版の 2 本立て）。
   環境は整っているので、そのまま書き始めてよい。
   形式化したら `lean/scripts/check-no-sorry.sh` の `targets` 配列へ定理名を追加し、
   人手証明のブロックの `lean` フィールドにも定理名を書く。
2. **章「有限系の自由エントロピー」を書く**。$\Phi_L=\log Z_L(q)\in\Lambda$（$q\in\mathbb{Q}_{>0}$、
   値の素因数分解の指数ベクトル）。SageMath 検証は既に $L=1,2,3$ で
   $Z_L(1/2)=2,\ 2^{-7}\cdot353,\ 2^{-11}\cdot9859$ を出しているので、そこから始められる。
3. **章「転送行列」**。$T(x)\in M_{2^L}(\mathbb{Z}[x])$ と $Z_L(x)=\operatorname{Tr}T(x)^L$。
   指数形 $e^{K\sigma\sigma'}$ を経由しない経路で書く（README「形式変数のまま進む」）。

## 未解決の設計問題

- **content のファイルを分けるときの文書順の決め方。** システム（リポジトリ直下
  `structured-latex/`）は `content/` のファイル名昇順を文書順とみなす。一方リポジトリの規約は
  ファイル名の連番プレフィックスを禁じている。現状は 1 ファイルなので配列順が文書順として機能しており
  衝突していないが、章を増やすときにどちらかを変える必要がある
  （システム側に明示的な順序宣言を入れるのが筋。人間へ提案してから決める）。

## 確認事項・注意

- **検証が本文を直させた例を消さない。** 辺集合を「2 元集合の集合」として定義していたため
  周期境界の $L\le2$ で $|E_L|=2L^2$ が破れていた。SageMath 検証が検出し、本文を
  「辺の番号の集合（横向き・縦向きに分割）と端点写像」の定義へ直した。
  経緯は `sagemath/check/partition-polynomial-coefficient-sum/overview.md` に残してある。
- 本文の地の文に強調記法（`**`）を使わない（他プロジェクトと同じ運用）。
- 姉妹プロジェクト `exact-solution-of-2d-ising-model/` の計算を引き写さない。
  可算側で書き直せるかを毎回問う（README「姉妹プロジェクトとの違い」）。

## 完了済み

- プロジェクト雛形の作成（構造化テキスト・SageMath・Lean・docs、および検査の一式）。
- 住処 `habitat` と脱出 `realEscape` の型・実行時強制、負テスト 8 件・実行時テスト 9 件。
- 可算な住処を宣言したブロックの数式に $\mathbb{R}/\mathbb{C}$ が現れないことの機械検査。
