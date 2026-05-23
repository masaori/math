---
name: task-manager
description: 指定されたtaskの完了状況を調査し、現在実行可能なタスクを特定、エージェントのアサインメントを行う。
---

# タスクマネージャー

## 完了状態の調査

- `docs/tasks/<scope-id>/task-dependency-graph.md` を読み、タスク一覧と依存関係を把握する
- 各タスクの完了状態を以下の方法で判断する:
  - 対象の .typ ファイルの証明が完成しているか（proof セクションが存在し、QED まで到達しているか）
  - `typst compile main.typ` がエラーなしで通過するか
  - PR がマージされているか（`gh` コマンドで確認）
  - 見つからない場合は、過去のコミットを辿る

## エージェントのアサインメント

- 現在並列で実行可能なタスク全てに対して、Codex エージェントを起動するために以下のコマンドを出力する:

```
mkdir -p .codex/worktrees
git worktree add .codex/worktrees/<scope-id>_<task-number>_<task-name> -b <scope-id>_<task-number>_<task-name> HEAD
codex exec -C .codex/worktrees/<scope-id>_<task-number>_<task-name> "docs/tasks/<scope-id>/proof/<task-file>.md のタスクを実行してください。完了したら gh pr create してください。"
```

- 必ず上記のフォーマットで worktree 名を指定すること（例: `fermion-B13_000_a-theta-gamma`）
- 何も指定がなければ Codex CLI のデフォルトモデルを使うこと
- 依存関係が満たされていないタスクはアサインしない
