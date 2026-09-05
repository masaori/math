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
- **下流の検算から再利用されるディレクトリは、`construction.sage`（再利用する厳密構成）と
  `check.sage`（観測の出力と assertion）に分ける。下流は `construction.sage` だけを読む。**
  以前は `check.sage` が上流の `check.sage` を読んでいたため、弧署名の検算を一本走らせるだけで
  先行 36 本の assertion が毎回再実行され、読み込みだけで 13 分かかっていた（実測 2026-09-05。
  自動ループの tick はこれで 2700 秒の上限に当たり exit 124 で落ちた）。分けたあとは
  同じ連鎖の読み込みが 2 分 44 秒である。
  - `construction.sage` に **関数の外の `assert` と `print` を置かない**。関数の中の `assert`
    （well-defined 性の番人）はそのまま残す。
  - `check.sage` は自分の `construction.sage` を読み、**上流の `check.sage` は読まない**。
  - 構成へ移した文にもとから `assert` が付いていた場合は、その文を原文のまま `check.sage` へも
    置いて回す。**assertion を減らさない**（先行検算は日次監査が `check.sage` を全数で回して維持する）。
  - この規約が守られているかは `bash scripts/verify-upstream-load-and-roadmap.sh` が機械検査する。

## 構成

```text
sagemath/
├── _shared/defs.sage   # 本文の定義に 1 対 1 対応する共通定義
├── check/<対象名>/     # overview.md（対象ラベルと結果）＋ check.sage
│                       # 下流から読まれるものは construction.sage（構成）も持つ
└── tools/verify-check-linkage.ts  # 検証 ↔ 証明 の対応の機械検証
```

## 実行

```sh
sage sagemath/check/<対象名>/check.sage
node sagemath/tools/verify-check-linkage.ts
```
