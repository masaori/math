# 自動ループ 状態

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`。

```yaml
current_cycle: 0
last_run: null          # 最後に daily 実行した日付（YYYY-MM-DD）
cron_armed: null        # cron を作成/再武装した日付
```

## cycle 0 step 列

slice は `inputs/seeds/canonical-papers.md` 準拠。slice 1（six_vertex_dwbc_determinant）は既に harvest/gap_map/generate 済み（`outputs/maps/001_...`, `outputs/candidates/000_...`）なので step 列から除外。

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | harvest:rsos_character_identity | todo | | |
| 2 | gap_map:rsos_character_identity | todo | | |
| 3 | generate:rsos_character_identity | todo | | |
| 4 | harvest:tl_loop_finitized_character | todo | | |
| 5 | gap_map:tl_loop_finitized_character | todo | | |
| 6 | generate:tl_loop_finitized_character | todo | | |
| 7 | harvest:dimer_pfaffian_boundary | todo | | |
| 8 | gap_map:dimer_pfaffian_boundary | todo | | |
| 9 | generate:dimer_pfaffian_boundary | todo | | |
| 10 | rank:cycle0 | todo | | 4 slice 出揃ってから。cycle 0 成功条件。 |
| 11 | decide:cycle1 | todo | | 観察に基づき cycle 1 step 列をこのファイルへ書き起こす。 |

## 逸脱ログ

MVP コンセプトマッチ点検で不合格になり是正した内容を、step 番号・日付付きで記録する。

（なし）
