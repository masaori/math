# SageMath Check: maximum_value_of_real_family_is_unique

## 対象

**対象ラベル**: `maximum_value_of_real_family_is_unique` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_maximum_value_of_real_family_is_unique`（実数の族の最大値は一つしかない）
- 範囲: 主張と、証明の 2 本の 2 行の鎖（`m = x_{i_0} ≤ m'`・`m' = x_{i_0'} ≤ m`）と反対称律の結論

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 2 本の鎖と結論 | `check_uniqueness_chain.sage` | `def_maximum_value_of_real_family` の (1)(2) を満たす値の組 `m, m'` を族の値から全部取り、各行と `m = m'` を確かめる | **PASS** | 族 162 個（項の数 1〜8、同じ値が繰り返す族を含む）、最大値の組（重複を除く）162 組、鎖の段 648 段で厳密 |
| 否定コントロール | 同上 | (2) だけを満たす上界 `max + 1` と、(1) だけを満たす値（最大でない族の値）は最大値の定義を満たさない | **PASS** | 700 件 |

## 計算の帰属と範囲

値はすべて `QQ` で、浮動小数点と `RR` / `CC` への脱出はない。主張は値の順序だけを使う。一般の集合 `S` 上の実数の族は人手証明が担い、
ここでは有限の有理数の族で、各行に書かれた不等号の向きと添字の取り方の写し間違いを検出する。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh maximum_value_of_real_family_is_unique
```

実行ログは `logs/` に保存してある（2026-11-04）。
