# SageMath Check: 053_claim_even_sector_closing の旧 check_05（退避）

## 対象

退避対象: `onsager_exact_solution` の旧証明が引いていた `c(M) = max(c_+(M), c_-(M))`
（`sector_decomposition_of_rayleigh_sup`）と、`c_-(M)` と `Λ^{(0)}_M` の対照

(−) セクターを本文から外したとき（2026-09-26）、`onsager_exact_solution` の Step 2 は `c_plus_le_c`
（`c_+(M) ≤ c(M)`）を引く形に、Step 3 は `epsilon_is_real_symmetric`・`epsilon_commutes_with_W` を引く形に変わり、
`c(M) = max(c_+, c_-)` は参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避された。
`check/053_claim_even_sector_closing/check_05_free_energy_limit.sage` は新しい証明に合わせて書き直した。
ここは書き直す前の check_05 の記録である。

| ファイル | 検証内容 | ステータス |
|---|---|---|
| `check_05_free_energy_limit.sage` | (1) `c(M) = max(c_+(M), c_-(M))`、(2) 対照 `c_-(M)` と `Λ^{(0)}_M`、(3) 挟み撃ち、(3') `c(M) = c_+(M)`、(4) Onsager 積分への収束、(5) `N_row` 依存 | PASS |

### この検査が残している一次情報

**`c_-(M) = Λ^{(0)}_M` は一般には成り立たない。** 高温側 `(K_1,K_2) = (0.05, 0.1)` では
`c_-(M)/Λ^{(0)}_M = 0.1102`（`M = 2,3,4,5`）で一致しない（`logs/check_05_free_energy_limit.sage.log` の (2)）。
これが `onsager_exact_solution` が `c_-(M)` の値に依存しない書き方をしている理由であり、本文の
`onsager_exact_solution` の `conversion.notes` もこの対照に言及している。

## 実行方法

`_prelude.sage` は移動元の複製で、共有ライブラリを `../../../_shared/spin_ops.sage` から読む。このディレクトリで実行する。
2026-09-26 に SageMath 10.9 で再実行し、PASS した（`logs/`）。
