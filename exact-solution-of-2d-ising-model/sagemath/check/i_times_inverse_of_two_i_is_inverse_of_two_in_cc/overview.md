# SageMath Check: i_times_inverse_of_two_i_is_inverse_of_two_in_cc

## 対象

**対象ラベル**: `i_times_inverse_of_two_i_is_inverse_of_two_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_i_times_inverse_of_two_i_is_inverse_of_two_in_cc`（`i(2_C i)^{-1} = 2_C^{-1}`）
- 範囲: 主張の前置き（`2_C, i, 2_C i ∈ ℂ^×`）と、証明の鎖の 6 等号
- 引く側: `exp_of_negative_i_real_as_cos_minus_i_sin` の主鎖の 17 行目、`relation_of_gamma_2_theta_tilde`・`periodicity_of_check_fermi` の準備の第一の鎖の 6 行目

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 前置きの `2_C, i, 2_C i ≠ 0_C` と、鎖 `i(2_C i)^{-1} = 1_C(i(2_C i)^{-1}) = … = 2_C^{-1}` の各行 | `check_chain.sage` | ℂ を `QQ` の対で持ち、積を `definition_of_cc` の式で書き、逆元を `multiplicative_group_of_cc` の証明の逆元の式 `(x,y)^{-1} := (x/(x^2+y^2), -y/(x^2+y^2))` で作り、各行を組んで隣り合う行が等しいことを見る。対照: 2 行目の `2_C^{-1}2_C` を `2_C` に替えると等号が切れる | **PASS** | 成り立つ |

## 計算の帰属と範囲

成分はすべて `QQ` の元である。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh i_times_inverse_of_two_i_is_inverse_of_two_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-11）。
