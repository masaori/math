# papers

実際に執筆する論文本体を置く。

`outputs/paper-plans/` で論文案として育て、書くと決めたものをこのディレクトリに昇格させる。
昇格の判断基準と手順は `outputs/paper-plans/README.md`（G1–G6 とユーザー承認ゲート）に定める。

## 標準構成

```text
001_<topic>/
├── README.md
├── refs.bib
├── computations/
└── notes.md
```

## 役割

- `README.md`: **論文本文の所在**（構造化テキストのどのファイル群か）、検証コマンド、論文の性質。
- `refs.bib`: 参考文献。**本文で本文確認済みのものだけ**を載せる。
- `computations/`: 検証計算への参照（実体は `sagemath/check/<dir>/` に置いたままとし、ここにはパスと実行手順、
  および論文の主張との対応表を書く）。紐づかない検証があればその理由も書く。
- `notes.md`: 投稿方針、未完了作業、未解決リスク、過去に検出・訂正した誤り。

## 本文はここに置かない

**論文本文（証明の正本）は `structured-latex/content/` に置く。** リポジトリ直下の `CLAUDE.md` が
「証明の正本は構造化テキストとする。Typst で新規に証明を書かない」と定めているためである。
旧版の標準構成は `main.typ` と `parts/` を挙げていたが、この規約に反するので 2026-07-26 に改めた。

論文本文と検証・形式検証の対応は、構造化テキストのブロックがもつフィールドで宣言する。

- `verification`: 対応する `sagemath/check/<dir>/` のパス
- `lean`: 対応する Lean 定理名

対応が切れていないことは `node sagemath/tools/verify-check-linkage.ts` で機械検証する。
