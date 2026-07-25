# AGENTS.md

このリポジトリで作業するエージェント向けの規約。**詳細は [CLAUDE.md](CLAUDE.md) を正本とする**
（リポジトリ構成・命名規則・本文とノートの使い分け・検証コマンドはそちらに集約）。

ここには、特に見落とされやすい厳守事項だけを再掲する。

## 作業完了時は指示がなくても main に push する（厳守）

- **依頼された作業が完了したら、指示がなくても必ず main に push すること。**
  「完了したが push は指示待ち」で止めてはならない。
- worktree やフィーチャーブランチで作業した場合も、完了したら main へ反映する
  （直接 push、または PR 作成・マージ）。
- 対象は docs に限らず、証明・コード・検証・設定などすべての作業。
- push 前に該当プロジェクトの `MEMORY.md` を更新する。
- push したら、**反映先（main）と反映に用いたコミット範囲または PR を明示して報告**する。
- サブエージェントには commit/push させない。**呼び出し元が成果を検証してから push する。**

## push 前に必ず通す検証

証明プロジェクト（例: `exact-solution-of-2d-ising-model/`）では以下をすべて通すこと。

```
node structured-latex/tools/validate-content.mjs      # スキーマ・ラベル重複・未解決参照・ノートの未解決 targets
node structured-latex/tools/verify-no-lost-proofs.mjs # 移行漏れ（原本に証明があるのに本文が未完のまま）
node sagemath/tools/verify-check-linkage.mjs          # 数値検証と証明の対応
cd lean && lake build && bash scripts/check-no-sorry.sh   # 機械的証明（lean/ がある場合）
```

**ブロック数や参照解決だけを見て「同期完了」と判断しないこと。**
過去に、証明の中身が移行されていないのに「完全同期」としてコミットし、
主要定理2件の証明が 100 コミット以上にわたって失われていた事故がある。

## 証明の正本

- 正本は `structured-latex/content/`。**修正は必ずここに入れる。**
- `_old/typst/` は参照用の温存アーカイブ。**更新しない**（直しても正本には反映されない）。
- 最終成果物（論文・書籍）は `content/` だけから生成する。
  参照用ノートは `structured-latex/notes/` に分離してあり、出版物には載らない。
