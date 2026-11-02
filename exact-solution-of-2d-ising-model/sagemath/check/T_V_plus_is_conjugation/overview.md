# SageMath Check: T_V_plus_is_conjugation

## 対象

**対象ラベル**: `T_V_plus_is_conjugation`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_claim_T_V_plus_is_conjugation`（`T_{(V^{(+)})} = T_{V^{(+)}}`）
- 範囲: 証明の準備（四つの可逆性と `T_g(X) = (gX)g^{-1} = T'_g(X)`）、値の鎖の全 8 行、主張（写像としての等号）

## 証明の行との対応

`S := (V_1^{(+)})^{1/2}`（証明の記号）。`T_g` は `def_T_g`、`T'_g` は `mat_conj` の共役（`n → 2^{M_col}`）である。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: `S, V_2, SV_2, V^{(+)} ∈ R^×` | `check_preparation_exact.sage` | 逆元の候補（`S^{-1} = exp(-X)`（`V1_plus_half_invertible` の指数 X）、`V2_invertible` の `h`、(ii) の `V_2^{-1}S^{-1}`、`S^{-1}(V_2^{-1}S^{-1})`）を掛けると両順で I。対照: `S^{-1}V_2^{-1}` は `SV_2` の逆元にならない | **PASS** | `M_col = 2..4`、`x, y ∈ {2, 3}` で厳密等号 |
| 準備: `T_g(X) = (gX)g^{-1} = T'_g(X)` | 同上 | 成分が独立な不定元の X について、`def_T_g` の値（Sage の積と inverse）と `T'_g` の値（`mat_mult` の成分の式と上の逆元）が一致（`g ∈ {S, V_2, SV_2, V^{(+)}}`） | **PASS** | 同上 |
| `T_{(V^{(+)})}(X) = T_S(T_{V_2}(T_S(X)))`（`def_T_V_plus`） | `check_chain_exact.sage` | L0 を `def_T_g` の入れ子で作る | **PASS** | 同上 |
| `= T'_S(T'_{V_2}(T'_S(X)))`（準備の 3 か所） | 同上 | L1 を `T'` の入れ子で作り L0 と一致（逆元の作り方が L0 と違う） | **PASS** | 同上 |
| `= (T'_S ∘ T'_{V_2})(T'_S(X))`（合成の定義） | 同上 | 定義の展開で計算を含まない（下の「確かめられない行と理由」） | 計算なし | — |
| `= T'_{SV_2}(T'_S(X))`（合成則 `G → S, H → V_2`） | 同上 | 逆元を合成則の証明の `H^{-1}G^{-1}` で作った L3 が L2 と一致。対照: `T'_{V_2S}` では一致しない | **PASS** | 同上 |
| `= (T'_{SV_2} ∘ T'_S)(X)`（合成の定義） | 同上 | 定義の展開で計算を含まない | 計算なし | — |
| `= T'_{(SV_2)S}(X)`（合成則 `G → SV_2, H → S`） | 同上 | 逆元を `S^{-1}(V_2^{-1}S^{-1})` で作った L5 が L4 と一致 | **PASS** | 同上 |
| `= T'_{V^{(+)}}(X)`（`def_V_plus`） | 同上 | 定義による置き換えで計算を含まない。L5 と同じ行列で逆元を Sage の inverse に替えた L6 が L5 と一致すること（逆元の一意性）だけを確かめる | **PASS** | 同上 |
| `= T_{V^{(+)}}(X)`（準備） | 同上 | `def_T_g` の値の L7 が L6 と一致 | **PASS** | 同上 |
| 主張 `T_{(V^{(+)})} = T_{V^{(+)}}` | 同上 | 不定元の X で L0 = L7（全ての X ∈ R の値の一致）。対照: 合成の順を替えた `T_{V_2}(T_S(T_S(X)))` は一致しない | **PASS** | 同上 |

## 計算の帰属と範囲

- `K_1 := 2 log y`、`K_2 := log x`（`x, y ∈ {2, 3}`）と選ぶと、`S^{±1} = exp(±X)`（`V1_plus_half_invertible` の指数 X）は `iH_1^{(+)}` の整数の固有値の射影の和として `QQ` に、
  `V_2` は `def_transfer_matrix` の成分として `QQ` に、`V_2^{-1}` は `V2_invertible` の証明の `h = (a^{-1})_C exp(-Y)` として `AA` に厳密に乗る
  （共通の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage`）。ℝ への脱出は `K_1`・`K_2` の選び方だけである。
- 全成分を `number_field_elements_from_algebraics` で一つの数体へ厳密に移し、X は成分が独立な不定元の行列（その数体上の多項式環）にした。
  不定元の X での等号は、選んだ `K_1, K_2` について全ての `X ∈ R` での等号を表す。浮動小数点は使わない。
- 各値は別の経路で作る: `def_T_g` の値は Sage の行列積と `inverse`、`T'` の値は `mat_mult` の成分の式と主張が与える逆元。
- 範囲外: `M_col ≥ 5`、上に挙げた以外の `K_1, K_2`。

## 確かめられない行と理由

- 鎖の「写像の合成の定義」の 2 行は `(f∘g)(X) := f(g(X))` の展開で、計算を含まない。コードは合成関数で値を作って assert を置いているが、両辺は同じ式になる。
- `def_V_plus` の行は `V^{(+)} := (SV_2)S` による置き換えで、計算を含まない。

- 準備の四つの可逆性は主張の引用（推論）であり、検算は逆元の候補で積が I になることを確かめる。
- 「`g^{-1}` は `conjugation_is_ring_homomorphism` の意味の逆行列でもある」は、二つの定義の条件 `gg^{-1} = I`・`g^{-1}g = I` が同じであることの読み取りで、計算を含まない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh T_V_plus_is_conjugation
```

実行ログは `logs/` に保存する。
