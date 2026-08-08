# SageMath による厳密計算検証

証明本文（`structured-latex/content/`）の式変形を**一行ずつ**機械に確かめさせる層。
[docs/context/証明の書き方.md](../../docs/context/証明の書き方.md) の四層検証の第 2 層。

## 規約

- **検証は厳密計算で行う。** `ZZ` / `QQ` / `QQbar` / `ZZ['x']` と素因数分解を使う。
  浮動小数点は $\mathbb{R}$ 脱出を含む量を確認するときだけ使い、使ったら `overview.md` に理由を書く。
  本文がその章で $\mathbb{R}$ へ脱出していないなら、検証側にも脱出を持ち込まない。
- **1 つの検証ディレクトリは 1 つの対象ラベルに対応する。** `overview.md` の冒頭で
  `**対象ラベル**: \`<label>\`` の形で宣言する。ラベルと content の対応は
  `node sagemath/tools/verify-check-linkage.ts` が機械検証する。
- **ディレクトリ名に連番を付けない**（リポジトリ直下 [CLAUDE.md](../../CLAUDE.md)）。
  内容が分かる名前を付ける（例: `partition-polynomial-coefficient-sum`）。
- **検証が失敗したら本文を直す。** 検証を主張に合わせて緩めない。失敗の記録は消さず
  `overview.md` に残す（実際、辺の定義の穴はこの層が検出した）。
- 共通定義は `_shared/defs.sage` に置き、**本文の定義ラベルと 1 対 1 で対応させる**。

## 構成

```text
sagemath/
├── _shared/defs.sage   # 本文の定義に 1 対 1 対応する共通定義
├── check/<対象名>/     # overview.md（対象ラベルと結果）＋ check.sage
└── tools/verify-check-linkage.ts  # 検証 ↔ 証明 の対応の機械検証
```

## 実行

```sh
sage sagemath/check/<対象名>/check.sage
node sagemath/tools/verify-check-linkage.ts
```
