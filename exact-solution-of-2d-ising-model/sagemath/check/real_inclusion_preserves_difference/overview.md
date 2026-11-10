# SageMath Check: real_inclusion_preserves_difference

## 対象

**対象ラベル**: `real_inclusion_preserves_difference` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_inclusion_preserves_difference`（実数の差の包含は包含の差に等しい）
- 範囲: 主張 `y_C - z_C = (y - z)_C` と、証明の八つの項（七つの等号）の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の七つの等号と主張 | `check_chain.sage` | `y, z` を `QQ` の不定元に置き、ℂ を実数の対として持って（`-1_C`・差・積・包含は対の定義式）、鎖の各項を行の表記どおりに作る。独立な経路として `QQ(i)[Y,Z]` の差の実部・虚部も読む。対照: 差を和に取り違えたもの、虚部が 0 でない数からの差は実数の像にならないこと | **PASS** | 厳密等号 |

## 計算の帰属と範囲

不定元の多項式の等号は厳密に決まり、任意の実数を代入しても保たれる（代入は環準同型である）。浮動小数点はない。

## 確かめられない行と理由

- 人手の 1 行目（`def_complex_difference`）、2 行目（`multiply_by_minus_one`）の等号は、差と符号反転を対の式で
  `cc_sub(z, w) = cc_add(z, cc_neg(w))`、`cc_neg(w) = cc_mul(iota(-1), w)` と作るので、一致は作り方から必ず通る。
- 人手の 3 行目（`-1_C = (-1)_C`）の等号は、両辺を同じ `iota` の同じ元で作るので、一致は作り方から必ず通る。`-1_C` が包含の像であることは `inclusion_rr_to_cc` の略記そのものである。
- 人手の 6 行目（実数の四則で `(-1)z` を加法の逆元 `-z` にする）と 7 行目（`def_real_difference` を右辺から左辺へ）は、`QQ[y,z]` の `(-1)*z`・`-z`・`y - z` が環の演算として同じ多項式になるので、一致は作り方から必ず通る。
- 値として独立に確かめているのは、人手の 4 行目（積の像）、5 行目（和の像）の等号と、`QQ(i)[Y,Z]` を通る独立な経路である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_inclusion_preserves_difference
```
