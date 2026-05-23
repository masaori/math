# papers

実際に執筆する論文本体を置く。

`outputs/paper-plans/` で論文案として育て、書くと決めたものをこのディレクトリに昇格させる。

## 標準構成

```text
001_<topic>/
├── main.typ
├── refs.bib
├── parts/
├── computations/
└── notes.md
```

## 役割

- `main.typ`: 論文本体。
- `refs.bib`: 参考文献。
- `parts/`: 定理、補題、証明、計算説明。
- `computations/`: SageMath/Python 等の検証コード。
- `notes.md`: 投稿方針、未完了作業、未解決リスク。
