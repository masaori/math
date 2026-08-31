import { createHash } from "node:crypto";
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { loadContentFiles } from "./content-modules.ts";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const finalChapters = ["数学的道具立て", "2次元イジングモデル"] as const;
type FinalChapter = typeof finalChapters[number];
const mathematicalToolFiles = new Set([
  "000_calculation_formulae_00_09.ts", "000_calculation_formulae_10_19.ts",
  "000_calculation_formulae_20_29.ts", "000_calculation_formulae_30_44.ts",
  "000_calculation_formulae_45_46.ts", "002_linear_space_general.ts",
  "003_exp_linear_map.ts", "005_exp_conjugation_proof.ts",
]);
const mathematicalToolEntryIdsOutsideToolFiles = new Set([
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_002_claim_trace_properties",
  "eigenvalues_of_V_003_claim_trace_of_idempotent",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "bridge_003_claim_exp_of_diagonal",
  "maxeig_005_claim_psd_cauchy_schwarz",
  "freeenergy_004_theorem_riemann_sum_to_integral",
  "critical_001_claim_cosh_addition_and_half_angle",
  "critical_008_claim_elementary_sine_bounds",
  "critical_009_claim_closed_form_log_integral",
  "critical_010_claim_sine_integral_two_sided",
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  "TV1_hatZ_hatY_definition_pauli_group",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
  "TV1_hatZ_hatY_010_definition_clifford_group",
]);
const matrixExponentialConjugationSectionEntryIds = [
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  "exp_conjugation_proof_008_theorem_exp_ad_series",
] as const;
const matrixExponentialConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", []],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", [
    "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  ]],
]);
const matrixExponentialConjugationExpectedContentSha256 = new Map<string, string>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "64229f938d8d19d12dd93c396ec488b8f44803a7f0f9d00b6c4b3ce8a115a867"],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", "c9e30902311cd76998b6716da76e040f081a0b4dcad42a5f1ad6d99331ab999b"],
]);
const matrixExponentialConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_conjugation_proof_004_theorem_ad_binomial",
  "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "exp_linear_map_004_theorem_exp_zero_is_identity",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity",
  "linear_space_general_003d_claim_matrix_completeness",
].sort();
const matrixLinearMapCorrespondenceSectionEntryIds = [
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
] as const;
const matrixLinearMapCorrespondenceExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_005_definition_end_isomorphism", []],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", [
    "transfer_matrix_005_definition_end_isomorphism",
    "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  ]],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
]);
const matrixLinearMapCorrespondenceExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", "1a9ecef9cd59f12d82071b4c248e4319f7c9be8e3f42cf1bc9289737d9e5d033"],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", "6b163e3b366800fd0dcda4eec827fa428e8721922ff5b3e064127c321b4d62c0"],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", "1a2d1ad2a81a5e00bb14c44c0527fe6bd668077325112d62a4a0e4278960c019"],
]);
const matrixLinearMapCorrespondenceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
].sort();
const matrixLinearMapCorrespondenceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000_definition_kronecker_product", "ce874671d3aca02c94e412408651b1c6a7a38d1e24c5d26ba1d3869134ce7385"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["linear_space_general_001_theorem_tensor_product_basis", "59e2b9e24e79916e00dfe666d29bdee556ea3479b16e89d9912457ff3bea0609"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "d4685720ab86b3cf07ecc5e19564d9c7e6467c8b488671eb775095e4b8ef8366"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
]);
const invertibleMatrixConjugationSectionEntryIds = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
] as const;
const invertibleMatrixConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", []],
  ["TV1_hatZ_hatY_011_definition_T_g", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
    "TV1_hatZ_hatY_011_definition_T_g",
    "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  ]],
]);
const invertibleMatrixConjugationExpectedContentSha256 = new Map<string, string>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
  ["TV1_hatZ_hatY_011_definition_T_g", "5f2b17e53697b3403829f55a1b07c6c85da5db2f0683d5e0d821ac74ac5baeb4"],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", "36a619c070399daf4e9acddd4cc7c0b7c1b285ba09e5abd36ecc9f4d23bcafaa"],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", "31eb30aa17a1240d5b78d3f1ccddc35af6843ad3b1be767250f2496e8620cb67"],
]);
const invertibleMatrixConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "linear_space_general_004_lemma_centralizer_is_scalar",
].sort();
const invertibleMatrixConjugationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["linear_space_general_001_theorem_tensor_product_basis", "59e2b9e24e79916e00dfe666d29bdee556ea3479b16e89d9912457ff3bea0609"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "dac86df17efd7a9fb3cc6421cdb38343493e285c3b2ff479207ad72e26fba1d5"],
  ["linear_space_general_004_lemma_centralizer_is_scalar", "a1e7706dec1460c8b6da421c8f57cd5e62eb65328f76a3320022d946f3e39573"],
]);
const pauliAndCliffordMatrixGroupsSectionEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "TV1_hatZ_hatY_definition_pauli_group",
  "TV1_hatZ_hatY_010_definition_clifford_group",
] as const;
const pauliAndCliffordMatrixGroupsExpectedInternalDependencies = new Map<string, string[]>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", []],
  ["TV1_hatZ_hatY_definition_pauli_group", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  ]],
  ["TV1_hatZ_hatY_010_definition_clifford_group", [
    "TV1_hatZ_hatY_definition_pauli_group",
  ]],
]);
const pauliAndCliffordMatrixGroupsExpectedContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "ab5911db8fb6a45aa867b393ea6ca15fc940c988a13e4f86a8678d1c8ed2111d"],
  ["TV1_hatZ_hatY_definition_pauli_group", "251f5e6d1a38e2b6eaf8eae4413d9b498ca0857207dc8918481a680a38064c7b"],
  ["TV1_hatZ_hatY_010_definition_clifford_group", "1196412a13aedcd3b42b2e18886fabb2e4cbe482e6bc9a8beb78c0bfa5d18c92"],
]);
const pauliAndCliffordMatrixGroupsExpectedExternalInputEntryIds = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
].sort();
const pauliAndCliffordMatrixGroupsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_003_matrix_decomposition", "a97a47798c1376adfb7b1536fdbb7d39f2a0953080fdf0177149de1f7ba89200"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
]);
const singleFactorAnticommutationSectionEntryIds = [
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
] as const;
const singleFactorAnticommutationExpectedInternalDependencies = new Map<string, string[]>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", []],
]);
const singleFactorAnticommutationExpectedContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", "f42f08b0069e29f6a2d4f3bab84d74e99a05fff95103e09a81d06a1581c8a27b"],
]);
const singleFactorAnticommutationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
].sort();
const singleFactorAnticommutationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
]);
const isingModelDefinitionSectionEntryIds = [
  "partition_function_2d_ising_001_definition_lattice_size",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
] as const;
const isingModelDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["partition_function_2d_ising_001_definition_lattice_size", []],
  ["partition_function_2d_ising_002_definition_partition_function", [
    "partition_function_2d_ising_001_definition_lattice_size",
  ]],
  ["partition_function_2d_ising_003_definition_transfer_matrix", [
    "partition_function_2d_ising_002_definition_partition_function",
  ]],
]);
const isingModelDefinitionExpectedContentSha256 = new Map<string, string>([
  ["partition_function_2d_ising_001_definition_lattice_size", "14296f06180cee80476d2042b80f8f3a4b68121b3e8e19b8adf0b2eb6193189a"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const isingModelDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
].sort();
const isingModelDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
]);
const spinConfigurationBasisSectionEntryIds = [
  "bridge_001_definition_config_basis",
] as const;
const spinConfigurationBasisExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_001_definition_config_basis", []],
]);
const spinConfigurationBasisExpectedContentSha256 = new Map<string, string>([
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
]);
const spinConfigurationBasisExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const spinConfigurationBasisExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const openChainSpinSumsSectionEntryIds = [
  "closing_005_definition_open_chain_spin_energy",
  "closing_005_claim_open_chain_endpoint_product_sum",
  "closing_005_claim_open_chain_partition_sum",
  "closing_005_claim_open_chain_spin_sums_positive",
] as const;
const openChainSpinSumsExpectedInternalDependencies = new Map<string, string[]>([
  ["closing_005_definition_open_chain_spin_energy", []],
  ["closing_005_claim_open_chain_endpoint_product_sum", ["closing_005_definition_open_chain_spin_energy"]],
  ["closing_005_claim_open_chain_partition_sum", ["closing_005_definition_open_chain_spin_energy"]],
  ["closing_005_claim_open_chain_spin_sums_positive", [
    "closing_005_claim_open_chain_endpoint_product_sum",
    "closing_005_claim_open_chain_partition_sum",
    "closing_005_definition_open_chain_spin_energy",
  ]],
]);
const openChainSpinSumsExpectedContentSha256 = new Map<string, string>([
  ["closing_005_definition_open_chain_spin_energy", "2062fa60483069fd13042b3bf943fdfaf32a14ae598f523f41b8b97380cc8f8d"],
  ["closing_005_claim_open_chain_endpoint_product_sum", "002ddb1410f5983a61e4df1c0cf886c47a43ca9825c9dc2563aa9bda84029d89"],
  ["closing_005_claim_open_chain_partition_sum", "97a1758b41d17a52343ba1188eecf112d46ba48112797988021d8d20669a19fc"],
  ["closing_005_claim_open_chain_spin_sums_positive", "c7a0451efa605dd17821efc7a433df7f151dee481ae5c7bb88f3003e2356da9b"],
]);
const openChainSpinSumsExpectedExternalInputEntryIds = [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_definition_cosh_sinh",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "partition_function_2d_ising_003_definition_transfer_matrix",
].sort();
const openChainSpinSumsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "a44423114f5dedf73c32f9319292e546e0bf14bb7167812f3ad58fc220eacc6a"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const partitionFunctionTraceSectionEntryIds = [
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
] as const;
const partitionFunctionTraceExpectedInternalDependencies = new Map<string, string[]>([
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", []],
]);
const partitionFunctionTraceExpectedContentSha256 = new Map<string, string>([
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", "f6a05c056f412bfa8b66d46ae8886cf2b931afb8cd09ba2e0bb42681e0bfecc5"],
]);
const partitionFunctionTraceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "eigenvalues_of_V_001_definition_trace",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
].sort();
const partitionFunctionTraceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "a44423114f5dedf73c32f9319292e546e0bf14bb7167812f3ad58fc220eacc6a"],
  ["eigenvalues_of_V_001_definition_trace", "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const v1PauliRepresentationSectionEntryIds = [
  "transfer_matrix_001_definition_symbols",
  "bridge_002_claim_sigma_z_diagonal_action",
  "bridge_004_claim_V1_component_equals_pauli",
] as const;
const v1PauliRepresentationExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_001_definition_symbols", []],
  ["bridge_002_claim_sigma_z_diagonal_action", [
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_002_claim_sigma_z_diagonal_action",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const v1PauliRepresentationExpectedDirectDependencies = new Map<string, string[]>([
  ["transfer_matrix_001_definition_symbols", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_definition_cosh_sinh",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "linear_space_general_000_definition_kronecker_product",
  ]],
  ["bridge_002_claim_sigma_z_diagonal_action", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "bridge_001_definition_config_basis",
    "calc_formulae_006_definition_of_cc",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "linear_space_general_000c_claim_kronecker_multilinear",
    "transfer_matrix_001_definition_symbols",
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "bridge_003_claim_exp_of_diagonal",
    "calculation_formulae_definition_set_and_algebra_notation",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const v1PauliRepresentationExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
]);
const v1PauliRepresentationExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_001_definition_config_basis",
  "bridge_003_claim_exp_of_diagonal",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_definition_cosh_sinh",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const v1PauliRepresentationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "ab5911db8fb6a45aa867b393ea6ca15fc940c988a13e4f86a8678d1c8ed2111d"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["linear_space_general_000_definition_kronecker_product", "ce874671d3aca02c94e412408651b1c6a7a38d1e24c5d26ba1d3869134ce7385"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
]);
const nextIsingBoundaryComparisonEntryIds = [
  "bridge_004_claim_V1_component_equals_pauli",
  "bridge_005_claim_two_by_two_transfer_identity",
  "bridge_006_claim_V2_component_equals_pauli",
  "bridge_007_claim_partition_function_in_pauli_form",
] as const;
const nextIsingBoundaryComparisonExpectedChapterOrders = new Map<string, number>([
  ["bridge_004_claim_V1_component_equals_pauli", 12],
  ["bridge_005_claim_two_by_two_transfer_identity", 13],
  ["bridge_006_claim_V2_component_equals_pauli", 14],
  ["bridge_007_claim_partition_function_in_pauli_form", 15],
]);
const nextIsingBoundaryComparisonExpectedDependencies = new Map<string, string[]>([
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "bridge_003_claim_exp_of_diagonal",
    "calculation_formulae_definition_set_and_algebra_notation",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_005_claim_two_by_two_transfer_identity", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_006_claim_V2_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_003_claim_exp_of_diagonal",
    "bridge_005_claim_two_by_two_transfer_identity",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "linear_space_general_000_definition_kronecker_product",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "linear_space_general_000c_claim_kronecker_multilinear",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_007_claim_partition_function_in_pauli_form", [
    "bridge_001_definition_config_basis",
    "bridge_004_claim_V1_component_equals_pauli",
    "bridge_006_claim_V2_component_equals_pauli",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "eigenvalues_of_V_002_claim_trace_properties",
    "partition_function_2d_ising_002_definition_partition_function",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const nextIsingBoundaryComparisonExpectedContentSha256 = new Map<string, string>([
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
  ["bridge_005_claim_two_by_two_transfer_identity", "7488a4fdc7984a8ad7c60219a39eca26d92d3230df4c5c43d320c7931df8d8ee"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["bridge_007_claim_partition_function_in_pauli_form", "33cd6cefa483928ac5bb3e3c71983a82af17222c9030b9596522b8ef575e219a"],
]);
const nextIsingBoundaryComparisonExpectedInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "ab5911db8fb6a45aa867b393ea6ca15fc940c988a13e4f86a8678d1c8ed2111d"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
  ["bridge_005_claim_two_by_two_transfer_identity", "7488a4fdc7984a8ad7c60219a39eca26d92d3230df4c5c43d320c7931df8d8ee"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_001_sqrt_nonnegative_real", "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "23b32729c264057d48a0ed8887f614269014d1583ca4848ed7a6629e1f49574c"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "d4685720ab86b3cf07ecc5e19564d9c7e6467c8b488671eb775095e4b8ef8366"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "a44423114f5dedf73c32f9319292e546e0bf14bb7167812f3ad58fc220eacc6a"],
  ["eigenvalues_of_V_002_claim_trace_properties", "93df4cac57894b68d57c2eb9759e701189dc1673bfe4758a1fc3a39124645672"],
  ["linear_space_general_000_definition_kronecker_product", "ce874671d3aca02c94e412408651b1c6a7a38d1e24c5d26ba1d3869134ce7385"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "59404eda021b5d904e2248530a586d168aea7d32d03451a45a17bb2f8b583a21"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e06631c60e429b8e755520b8069138cab273e66c4946ec5a46c83dc4293738a7"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", "f6a05c056f412bfa8b66d46ae8886cf2b931afb8cd09ba2e0bb42681e0bfecc5"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const v2PauliPartitionFunctionSectionEntryIds = [
  "bridge_005_claim_two_by_two_transfer_identity",
  "bridge_006_claim_V2_component_equals_pauli",
  "bridge_007_claim_partition_function_in_pauli_form",
] as const;
const v2PauliPartitionFunctionExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_005_claim_two_by_two_transfer_identity", []],
  ["bridge_006_claim_V2_component_equals_pauli", [
    "bridge_005_claim_two_by_two_transfer_identity",
  ]],
  ["bridge_007_claim_partition_function_in_pauli_form", [
    "bridge_006_claim_V2_component_equals_pauli",
  ]],
]);
const v2PauliPartitionFunctionExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_001_definition_config_basis",
  "bridge_003_claim_exp_of_diagonal",
  "bridge_004_claim_V1_component_equals_pauli",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_002_claim_trace_properties",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
].sort();
const epsilonProjectorDefinitionSectionEntryIds = [
  "bridge_008_definition_epsilon_projectors",
] as const;
const epsilonProjectorDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_008_definition_epsilon_projectors", []],
]);
const epsilonProjectorDefinitionExpectedContentSha256 = new Map<string, string>([
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
]);
const epsilonProjectorDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "transfer_matrix_001_definition_symbols",
].sort();
const epsilonProjectorDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const kappaDefinitionSectionEntryIds = ["critical_002_definition_kappa"] as const;
const kappaDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["critical_002_definition_kappa", []],
]);
const kappaDefinitionExpectedContentSha256 = new Map<string, string>([
  ["critical_002_definition_kappa", "acd5ce9a1658584ca9ece23706585a304c38ac9e05fdd1474805b4cd4dd2a556"],
]);
const kappaDefinitionExpectedExternalInputEntryIds = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "transfer_matrix_001_definition_symbols",
].sort();
const kappaDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const criticalSinhProductDefinitionSectionEntryIds = ["critical_002a_definition_critical_sinh_product_A"] as const;
const criticalSinhProductDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["critical_002a_definition_critical_sinh_product_A", []],
]);
const criticalSinhProductDefinitionExpectedContentSha256 = new Map<string, string>([
  ["critical_002a_definition_critical_sinh_product_A", "689b4ecec986b56c91068263f15b1040aa6c8ef957e855678ca67710aa8587bf"],
]);
const criticalSinhProductDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation",
  "transfer_matrix_001_definition_symbols",
].sort();
const criticalSinhProductDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const symmetrizedTransferMatrixExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "transfer_matrix_001_definition_symbols",
].sort();
const traceOfSymmetrizedTransferMatrixExpectedDirectDependencies = [
  "bridge_007_claim_partition_function_in_pauli_form",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_002_claim_trace_properties",
  "maxeig_001_definition_symmetrized_transfer_matrix",
].sort();
const nonPrerequisiteReferenceLabelsById = new Map<string, Set<string>>([
  ["calc_formulae_006_definition_of_cc", new Set(["abs_basic_properties", "matrix_exp_series_converges"])],
  ["linear_space_general_000_definition_kronecker_product", new Set(["kronecker_product_rule", "tensor_basis"])],
  ["TV1_hatZ_hatY_001_claim_commutator_H_Z_Y", new Set(["why_008_applies_only_to_minus_sector"])],
  ["TV1_hatZ_hatY_027_claim_eigenvector_A_theta", new Set(["A_theta_is_identity_when_gamma2_zero"])],
]);
const forwardNavigationReviewById = new Map<string, Map<string, string>>([
  ["calculation_formulae_definition_set_and_algebra_notation", new Map([["definition_of_cc", "既存の複素数定義への案内"]])],
  ["calc_formulae_006_definition_of_cc", new Map([["abs_basic_properties", "後続利用への案内"], ["matrix_exp_series_converges", "後続利用への案内"]])],
  ["TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group", new Map([["def_T_g", "後続の比較対象への案内"]])],
  ["TV1_hatZ_hatY_030_definition_fermi", new Map([["T_V_eq_T_Vprime_on_hatZ_hatY", "後続利用への案内"], ["T_Vprime_fixes_hatZ_hatY_when_gamma2_zero", "例外処理への案内"], ["critical_condition_c1_eq_s1_c2", "例外条件への案内"]])],
  ["freeenergy_002_claim_gamma_is_continuous", new Map([["riemann_sum_to_integral", "後続利用への案内"]])],
  ["evensector_002_claim_antiperiodic_exp_sum", new Map([["def_check_index_set", "後続表記への案内"]])],
  ["evensector_003_definition_half_integer_modes", new Map([["def_check_index_set", "後続表記への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evensector_003a_definition_check_index_set", new Map([["anticommutator_of_check_Z_Y", "後続利用への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evenEigen_004_claim_trace_of_check_number_operator_product", new Map([["check_joint_eigenspace_decomposition", "後続対応への案内"]])],
  ["evenEigen_006_claim_eigenvalues_of_check_Vprime", new Map([["max_eigenvalue_of_V_plus_simple", "後続帰結への案内"]])],
  ["closing_002_claim_epsilon_eigenvalue_on_check_Q", new Map([["max_eigenvector_in_even_sector", "後続利用への案内"], ["trace_of_epsilon_V_plus", "後続の符号決定への案内"]])],
]);
const forwardPrerequisiteLabelsById = new Map<string, Set<string>>([
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", new Set(["def_hermitian_positive_definite", "def_trace"])],
  ["transfer_matrix_001_definition_symbols", new Set(["pauli_matrix_products"])],
]);
const manualGranularityReviewById = new Map<string, string>([
  ["calc_formulae_014b_claim_arcsin_bijection", "円弧長に関する外部命題の証明を本文内の一ステップ一定理へ展開する余地がある。分類境界と依存順は確定している。"],
  ["maxeig_001_definition_symmetrized_transfer_matrix", "V1 の平方根として使う行列と対称化転送行列 W という二つの定義を一ブロックへ束ねている。分割後に W から始まる依存鎖の節境界を再判定する必要がある。"],
  ["transfer_matrix_001_definition_symbols", "二次・多因子の単位行列、サイトごとの三つの Pauli 行列、V1・V2、Jordan–Wigner 行列、全スピン反転行列、双対結合定数、双曲線関数の略記という独立した定義を一ブロックへ束ねている。Pauli行列、cosh・sinh、その正値性は先行項を明示参照したが、tanh と実対数には独立した先行定義がなく、双対関係の後続証明は本項へ依存するため参照できない。分割後に節境界と依存順を再判定する必要がある。"],
]);
const isingPattern = /Ising|イジング|spin|スピン|lattice|格子|site|サイト|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const abstractPatterns = [
  { name: "リー群", pattern: /Lie\s*group|リー群/i },
  { name: "リー環", pattern: /Lie\s*algebra|リー環/i },
  { name: "抽象テンソル積", pattern: /abstract\s+tensor|抽象テンソル積/i },
  { name: "一般の体・環", pattern: /\\mathbb\{K\}|K :=|Mat\([^)]*,K\)|任意の体|一般の体|一般の環/i },
  { name: "抽象線型写像", pattern: /\\mathrm\{End\}|線型写像|linear\s+map/i },
  { name: "群の一般論", pattern: /群|group/i },
];

function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (Array.isArray(value)) for (const item of value) collectTargets(item, targets);
  else if (value !== null && typeof value === "object") {
    const record = value as Record<string, unknown>;
    if (record.type === "ref" && typeof record.target === "string") targets.add(record.target);
    for (const child of Object.values(record)) collectTargets(child, targets);
  }
  return targets;
}

function blockTitle(block: object): string | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  if ("text" in block.title && typeof block.title.text === "string") return block.title.text;
  if ("tex" in block.title && typeof block.title.tex === "string") return block.title.tex;
  return null;
}

function blockTitleFormat(block: object): "text" | "tex" | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  return "tex" in block.title ? "tex" : "text";
}

function stronglyConnectedComponents(nodes: string[], dependencies: Map<string, string[]>): string[][] {
  let index = 0;
  const indices = new Map<string, number>();
  const low = new Map<string, number>();
  const stack: string[] = [];
  const active = new Set<string>();
  const components: string[][] = [];
  function visit(node: string): void {
    indices.set(node, index); low.set(node, index); index += 1; stack.push(node); active.add(node);
    for (const dependency of dependencies.get(node) ?? []) {
      if (!indices.has(dependency)) { visit(dependency); low.set(node, Math.min(low.get(node)!, low.get(dependency)!)); }
      else if (active.has(dependency)) low.set(node, Math.min(low.get(node)!, indices.get(dependency)!));
    }
    if (low.get(node) !== indices.get(node)) return;
    const component: string[] = [];
    while (stack.length > 0) {
      const member = stack.pop()!; active.delete(member); component.push(member);
      if (member === node) break;
    }
    components.push(component.sort());
  }
  for (const node of [...nodes].sort()) if (!indices.has(node)) visit(node);
  return components;
}

function topologicalComponents(components: string[][], dependencies: Map<string, string[]>): string[][] {
  const owner = new Map<string, number>();
  components.forEach((component, i) => component.forEach((node) => owner.set(node, i)));
  const dependents = new Map<number, Set<number>>();
  const counts = new Map(components.map((_, i) => [i, 0]));
  for (const [node, prerequisites] of dependencies) for (const prerequisite of prerequisites) {
    const from = owner.get(prerequisite)!; const to = owner.get(node)!;
    if (from === to) continue;
    const targets = dependents.get(from) ?? new Set<number>();
    if (!targets.has(to)) { targets.add(to); dependents.set(from, targets); counts.set(to, counts.get(to)! + 1); }
  }
  const compare = (a: number, b: number) => components[a]!.join("\u0000").localeCompare(components[b]!.join("\u0000"));
  const ready = [...counts].filter(([, count]) => count === 0).map(([i]) => i).sort(compare);
  const result: string[][] = [];
  while (ready.length > 0) {
    const current = ready.shift()!; result.push(components[current]!);
    for (const dependent of dependents.get(current) ?? []) {
      counts.set(dependent, counts.get(dependent)! - 1);
      if (counts.get(dependent) === 0) { ready.push(dependent); ready.sort(compare); }
    }
  }
  if (result.length !== components.length) throw new Error("縮約依存グラフの順序を確定できません");
  return result;
}

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const targetBlocks = allBlocks.filter(({ block }) => ["definition", "claim", "theorem"].includes(block.kind));
const targetIds = new Set(targetBlocks.map(({ block }) => block.id));
const labelOwners = new Map<string, string>();
const blockPositionById = new Map(allBlocks.map(({ block }, position) => [block.id, position]));
for (const { block } of allBlocks) for (const label of block.labels) {
  if (labelOwners.has(label)) throw new Error(`ラベル所有者が重複しています: ${label}`);
  labelOwners.set(label, block.id);
}
const incoming = new Map<string, number>();
for (const { block } of allBlocks) for (const target of collectTargets(block)) incoming.set(target, (incoming.get(target) ?? 0) + 1);

const baseEntries = targetBlocks.map(({ file, block }) => {
  const record = block as unknown as Record<string, unknown>;
  const inspected = JSON.stringify({ title: record.title, statement: record.statement, proof: record.proof });
  const inspectedContentSha256 = createHash("sha256").update(inspected).digest("hex");
  const isingSemanticMatches = [...new Set(inspected.match(isingPattern) ?? [])].sort();
  const abstractVocabularyMatches = abstractPatterns.filter(({ pattern }) => pattern.test(inspected)).map(({ name }) => name);
  const toolCandidate = mathematicalToolFiles.has(file) || mathematicalToolEntryIdsOutsideToolFiles.has(block.id);
  const chapter: FinalChapter = toolCandidate && isingSemanticMatches.length === 0
    ? "数学的道具立て" : "2次元イジングモデル";
  const statementReferenceLabels = [...collectTargets(record.statement)].sort();
  const proofReferenceLabels = [...collectTargets(record.proof)].sort();
  const semanticPrerequisiteLabels: string[] = [];
  if (block.id !== "calculation_formulae_definition_set_and_algebra_notation" && /\\mathbb\s*(?:\{[NZR]\}|[NZR])/.test(inspected)) semanticPrerequisiteLabels.push("set_and_algebra_notation");
  if (!["calculation_formulae_definition_set_and_algebra_notation", "calc_formulae_006_definition_of_cc"].includes(block.id) && /\\mathbb\s*\{?C\}?/.test(inspected)) semanticPrerequisiteLabels.push("definition_of_cc");
  const rawReferenceLabels = [...new Set([...statementReferenceLabels, ...proofReferenceLabels, ...semanticPrerequisiteLabels])].sort();
  const configuredExclusions = nonPrerequisiteReferenceLabelsById.get(block.id) ?? new Set<string>();
  const forwardStatementReferenceLabels = statementReferenceLabels.filter((label) => {
    const ownerId = labelOwners.get(label);
    return ownerId !== undefined && blockPositionById.get(ownerId)! > blockPositionById.get(block.id)!;
  });
  const navigationReview = forwardNavigationReviewById.get(block.id) ?? new Map<string, string>();
  const forwardPrerequisites = forwardPrerequisiteLabelsById.get(block.id) ?? new Set<string>();
  const reviewedLabels = new Set([...navigationReview.keys(), ...forwardPrerequisites]);
  const forwardReviewMatches = forwardStatementReferenceLabels.every((label) => reviewedLabels.has(label))
    && [...reviewedLabels].every((label) => forwardStatementReferenceLabels.includes(label));
  const forwardStatementReferenceReview = navigationReview.size === 0 ? null : Object.fromEntries(navigationReview);
  const reviewedForwardNavigationLabels = forwardReviewMatches ? [...navigationReview.keys()] : [];
  const excludedReferenceLabels = new Set([...configuredExclusions, ...reviewedForwardNavigationLabels]);
  const dependsOnLabels = rawReferenceLabels.filter((label) => !excludedReferenceLabels.has(label));
  for (const label of semanticPrerequisiteLabels) if (!dependsOnLabels.includes(label)) {
    throw new Error(`記号使用から導いた意味的前提が依存辺にありません: ${block.id} -> ${label}`);
  }
  const dependsOnEntryIds = [...new Set(dependsOnLabels.map((label) => labelOwners.get(label))
    .filter((id): id is string => id !== undefined && id !== block.id && targetIds.has(id)))].sort();
  return {
    id: block.id, kind: block.kind, title: blockTitle(block), titleFormat: blockTitleFormat(block), labels: block.labels, sourceFile: file,
    sourceOrdinal: block.origin?.ordinal ?? null, provisionalFinalChapter: chapter,
    classificationEvidence: {
      mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
      mathematicalToolCandidateEntry: mathematicalToolEntryIdsOutsideToolFiles.has(block.id),
      incomingReferenceCount: block.labels.reduce((sum, label) => sum + (incoming.get(label) ?? 0), 0),
      isingSemanticMatches,
      rule: "項目ごとの意味レビューで一般的な複素数・行列計算と確認され、内容にイジング固有語彙がなければ数学的道具立て、それ以外は2次元イジングモデル",
      rationale: chapter === "数学的道具立て"
        ? "イジング模型を仮定せず、複素数・有限行列の具体的な定義または計算として再利用できる。"
        : "対象の意味または導入目的がスピン・格子・転送行列などイジング模型の構成に依存する。",
    },
    explanationGranularityReview: {
      status: abstractVocabularyMatches.length === 0 && forwardStatementReferenceLabels.length === 0 && !manualGranularityReviewById.has(block.id)
        ? "自動検査で主題に適合"
        : "具体的な行列計算への展開またはブロック分割を要する",
      criterion: "複素数と有限行列の成分・和・積・極限を、依存先から順に高校生が追える粒度で説明する",
      abstractVocabularyMatches,
      inspectedCharacterCount: inspected.length,
      inspectedContentSha256,
      forwardNavigationMixedIntoStatement: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
      inspectedFields: ["title", "statement", "proof"],
      manualReview: manualGranularityReviewById.get(block.id) ?? null,
    },
    dependsOnLabels, dependsOnEntryIds, semanticPrerequisiteLabels,
    referenceLabelsNotUsedAsPrerequisites: [...excludedReferenceLabels].sort(),
    forwardStatementReferenceLabelsNotUsedAsPrerequisites: reviewedForwardNavigationLabels,
    forwardStatementReferenceLabelsUsedAsPrerequisites: [...forwardPrerequisites].sort(),
    forwardStatementReferenceReview,
    blockSplitRequiredBeforeFinalOrdering: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
  };
});
const entryById = new Map(baseEntries.map((entry) => [entry.id, entry]));
const chapterStructures = finalChapters.map((chapter) => {
  const chapterEntries = baseEntries.filter((entry) => entry.provisionalFinalChapter === chapter);
  const chapterIds = new Set(chapterEntries.map(({ id }) => id));
  const dependencies = new Map(chapterEntries.map(({ id, dependsOnEntryIds }) => [id, dependsOnEntryIds.filter((x) => chapterIds.has(x))]));
  const ordered = topologicalComponents(stronglyConnectedComponents([...chapterIds], dependencies), dependencies);
  return {
    chapter, entryCount: chapterEntries.length, dependencyDirection: "prerequisite から dependent へ",
    topologicalOrder: ordered.map((entryIds, i) => ({ order: i + 1, entryIds, inseparableDependencyUnit: entryIds.length > 1 })),
    crossChapterPrerequisites: chapterEntries.flatMap((entry) => entry.dependsOnEntryIds
      .filter((id) => entryById.get(id)?.provisionalFinalChapter !== chapter)
      .map((prerequisiteId) => ({ dependentId: entry.id, prerequisiteId }))),
  };
});
const toolStructure = chapterStructures.find(({ chapter }) => chapter === "数学的道具立て")!;
if (toolStructure.crossChapterPrerequisites.length > 0) throw new Error(`数学的道具立てが後章を前提にしています: ${JSON.stringify(toolStructure.crossChapterPrerequisites)}`);
const order = new Map<string, { chapterOrder: number; dependencyUnitEntryIds: string[] }>();
for (const structure of chapterStructures) for (const unit of structure.topologicalOrder) for (const id of unit.entryIds) {
  order.set(id, { chapterOrder: unit.order, dependencyUnitEntryIds: unit.entryIds });
}
const entries = baseEntries.map((entry) => ({ ...entry, dependencyPlacement: order.get(entry.id) }));
const unresolvedBlockSplits = entries.filter((entry) => entry.blockSplitRequiredBeforeFinalOrdering);
if (unresolvedBlockSplits.length > 0) {
  throw new Error(`未レビューの前方参照が残っています: ${unresolvedBlockSplits.map(({ id }) => id).join(", ")}`);
}
const matrixExponentialConjugationSectionIdSet = new Set<string>(matrixExponentialConjugationSectionEntryIds);
const matrixExponentialConjugationSectionEntries = matrixExponentialConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列指数関数による共役の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列指数関数による共役の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixExponentialConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixExponentialConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列指数関数による共役の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixExponentialConjugationExpectedContentSha256.get(id)) {
    throw new Error(`行列指数関数による共役の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixExponentialConjugationSectionOrders = matrixExponentialConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixExponentialConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixExponentialConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列指数関数による共役の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixExponentialConjugationSectionOrders)}`);
}
const matrixExponentialConjugationInternalDependencyTargets = new Set(
  [...matrixExponentialConjugationExpectedInternalDependencies.values()].flat(),
);
const matrixExponentialConjugationTerminalEntryIds = matrixExponentialConjugationSectionEntryIds
  .filter((id) => !matrixExponentialConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(matrixExponentialConjugationTerminalEntryIds) !== JSON.stringify(["exp_conjugation_proof_008_theorem_exp_ad_series"])) {
  throw new Error(`行列指数関数による共役の節候補が節末の系へ閉じていません: ${JSON.stringify(matrixExponentialConjugationTerminalEntryIds)}`);
}
const matrixExponentialConjugationExternalInputEntryIds = [...new Set(
  matrixExponentialConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixExponentialConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixExponentialConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(matrixExponentialConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`行列指数関数による共役の節候補の外部入力が変わりました: ${JSON.stringify(matrixExponentialConjugationExternalInputEntryIds)}`);
}
const matrixLinearMapCorrespondenceSectionIdSet = new Set<string>(matrixLinearMapCorrespondenceSectionEntryIds);
const matrixLinearMapCorrespondenceSectionEntries = matrixLinearMapCorrespondenceSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列と線型写像の対応の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列と線型写像の対応の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixLinearMapCorrespondenceSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixLinearMapCorrespondenceExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列と線型写像の対応の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixLinearMapCorrespondenceExpectedContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixLinearMapCorrespondenceSectionOrders = matrixLinearMapCorrespondenceSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixLinearMapCorrespondenceSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixLinearMapCorrespondenceSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列と線型写像の対応の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixLinearMapCorrespondenceSectionOrders)}`);
}
const matrixLinearMapCorrespondenceInternalDependencyTargets = new Set(
  [...matrixLinearMapCorrespondenceExpectedInternalDependencies.values()].flat(),
);
const matrixLinearMapCorrespondenceTerminalEntryIds = matrixLinearMapCorrespondenceSectionEntryIds
  .filter((id) => !matrixLinearMapCorrespondenceInternalDependencyTargets.has(id));
if (JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)
  !== JSON.stringify([
    "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
    "transfer_matrix_claim_end_acts_on_kronecker_products",
  ])) {
  throw new Error(`行列と線型写像の対応の節候補が二つの節末出力へ閉じていません: ${JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)}`);
}
const matrixLinearMapCorrespondenceExternalInputEntryIds = [...new Set(
  matrixLinearMapCorrespondenceSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixLinearMapCorrespondenceSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixLinearMapCorrespondenceExternalInputEntryIds].sort())
  !== JSON.stringify(matrixLinearMapCorrespondenceExpectedExternalInputEntryIds)) {
  throw new Error(`行列と線型写像の対応の節候補の外部入力が変わりました: ${JSON.stringify(matrixLinearMapCorrespondenceExternalInputEntryIds)}`);
}
for (const id of matrixLinearMapCorrespondenceExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  if (entry.explanationGranularityReview.inspectedContentSha256
    !== matrixLinearMapCorrespondenceExpectedExternalInputContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補の外部入力本文が変わりました: ${id}`);
  }
}
const invertibleMatrixConjugationSectionIdSet = new Set<string>(invertibleMatrixConjugationSectionEntryIds);
const invertibleMatrixConjugationSectionEntries = invertibleMatrixConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`可逆行列と共役写像の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`可逆行列と共役写像の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => invertibleMatrixConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...invertibleMatrixConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`可逆行列と共役写像の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== invertibleMatrixConjugationExpectedContentSha256.get(id)) {
    throw new Error(`可逆行列と共役写像の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const invertibleMatrixConjugationSectionOrders = invertibleMatrixConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!invertibleMatrixConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === invertibleMatrixConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`可逆行列と共役写像の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(invertibleMatrixConjugationSectionOrders)}`);
}
const invertibleMatrixConjugationInternalDependencyTargets = new Set(
  [...invertibleMatrixConjugationExpectedInternalDependencies.values()].flat(),
);
const invertibleMatrixConjugationTerminalEntryIds = invertibleMatrixConjugationSectionEntryIds
  .filter((id) => !invertibleMatrixConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)
  !== JSON.stringify(["TV1_hatZ_hatY_011a_claim_injectivity_of_T"])) {
  throw new Error(`可逆行列と共役写像の節候補が節末の主定理へ閉じていません: ${JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)}`);
}
const invertibleMatrixConjugationExternalInputEntryIds = [...new Set(
  invertibleMatrixConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !invertibleMatrixConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...invertibleMatrixConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(invertibleMatrixConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`可逆行列と共役写像の節候補の外部入力が変わりました: ${JSON.stringify(invertibleMatrixConjugationExternalInputEntryIds)}`);
}
for (const id of invertibleMatrixConjugationExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  if (entry.explanationGranularityReview.inspectedContentSha256
    !== invertibleMatrixConjugationExpectedExternalInputContentSha256.get(id)) {
    throw new Error(`可逆行列と共役写像の節候補の外部入力本文が変わりました: ${id}`);
  }
}
function validateReviewedSection(
  sectionName: string,
  expectedChapter: FinalChapter,
  sectionEntryIds: readonly string[],
  expectedInternalDependencies: Map<string, string[]>,
  expectedContentSha256: Map<string, string>,
  expectedExternalInputEntryIds: string[],
  expectedExternalInputContentSha256: Map<string, string>,
  expectedTerminalEntryIds: string[],
) {
  const sectionIdSet = new Set(sectionEntryIds);
  const sectionEntries = sectionEntryIds.map((id) => {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`${sectionName}の節候補に必要な項目がありません: ${id}`);
    if (entry.provisionalFinalChapter !== expectedChapter) {
      throw new Error(`${sectionName}の節候補が${expectedChapter}にありません: ${id}`);
    }
    const actualInternalDependencies = entry.dependsOnEntryIds
      .filter((dependencyId) => sectionIdSet.has(dependencyId))
      .sort();
    const expected = [...expectedInternalDependencies.get(id)!].sort();
    if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expected)) {
      throw new Error(`${sectionName}の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
    }
    if (entry.explanationGranularityReview.inspectedContentSha256 !== expectedContentSha256.get(id)) {
      throw new Error(`${sectionName}の節候補のレビュー済み本文が変わりました: ${id}`);
    }
    return entry;
  });
  const sectionOrders = sectionEntries.map((entry) => entry.dependencyPlacement!.chapterOrder);
  if (!sectionOrders.every((chapterOrder, index) =>
    index === 0 || chapterOrder === sectionOrders[index - 1]! + 1)) {
    throw new Error(`${sectionName}の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(sectionOrders)}`);
  }
  const internalDependencyTargets = new Set([...expectedInternalDependencies.values()].flat());
  const terminalEntryIds = sectionEntryIds.filter((id) => !internalDependencyTargets.has(id));
  if (JSON.stringify(terminalEntryIds) !== JSON.stringify(expectedTerminalEntryIds)) {
    throw new Error(`${sectionName}の節候補が期待する節末出力へ閉じていません: ${JSON.stringify(terminalEntryIds)}`);
  }
  const externalInputEntryIds = [...new Set(
    sectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
      .filter((id) => !sectionIdSet.has(id)),
  )].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
  if (JSON.stringify([...externalInputEntryIds].sort()) !== JSON.stringify(expectedExternalInputEntryIds)) {
    throw new Error(`${sectionName}の節候補の外部入力が変わりました: ${JSON.stringify(externalInputEntryIds)}`);
  }
  for (const id of externalInputEntryIds) {
    const entry = entries.find((candidate) => candidate.id === id)!;
    if (entry.explanationGranularityReview.inspectedContentSha256 !== expectedExternalInputContentSha256.get(id)) {
      throw new Error(`${sectionName}の節候補の外部入力本文が変わりました: ${id}`);
    }
  }
  return { sectionEntries, externalInputEntryIds };
}
function validateNextIsingBoundaryComparison() {
  for (const id of nextIsingBoundaryComparisonEntryIds) {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`次のイジング節境界の比較対象がありません: ${id}`);
    if (entry.provisionalFinalChapter !== "2次元イジングモデル") {
      throw new Error(`次のイジング節境界の比較対象が2次元イジングモデル章にありません: ${id}`);
    }
    if (entry.dependencyPlacement!.chapterOrder !== nextIsingBoundaryComparisonExpectedChapterOrders.get(id)) {
      throw new Error(`次のイジング節境界の比較対象の章内依存順が変わりました: ${id}: ${entry.dependencyPlacement!.chapterOrder}`);
    }
    const actualDependencies = [...entry.dependsOnEntryIds].sort();
    const expectedDependencies = [...nextIsingBoundaryComparisonExpectedDependencies.get(id)!].sort();
    if (JSON.stringify(actualDependencies) !== JSON.stringify(expectedDependencies)) {
      throw new Error(`次のイジング節境界の比較対象の直接依存が変わりました: ${id}: ${JSON.stringify(actualDependencies)}`);
    }
    if (entry.explanationGranularityReview.inspectedContentSha256
      !== nextIsingBoundaryComparisonExpectedContentSha256.get(id)) {
      throw new Error(`次のイジング節境界の比較対象本文が変わりました: ${id}`);
    }
  }
  const comparisonInputIds = [...new Set(
    [...nextIsingBoundaryComparisonExpectedDependencies.values()].flat(),
  )];
  for (const id of comparisonInputIds) {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`次のイジング節境界の比較対象の外部入力がありません: ${id}`);
    if (entry.explanationGranularityReview.inspectedContentSha256
      !== nextIsingBoundaryComparisonExpectedInputContentSha256.get(id)) {
      throw new Error(`次のイジング節境界の比較対象の外部入力本文が変わりました: ${id}`);
    }
  }
}
validateNextIsingBoundaryComparison();
const pauliAndCliffordMatrixGroupsSection = validateReviewedSection(
  "Pauli 行列と共役で保たれる行列群",
  "数学的道具立て",
  pauliAndCliffordMatrixGroupsSectionEntryIds,
  pauliAndCliffordMatrixGroupsExpectedInternalDependencies,
  pauliAndCliffordMatrixGroupsExpectedContentSha256,
  pauliAndCliffordMatrixGroupsExpectedExternalInputEntryIds,
  pauliAndCliffordMatrixGroupsExpectedExternalInputContentSha256,
  ["TV1_hatZ_hatY_010_definition_clifford_group"],
);
const singleFactorAnticommutationSection = validateReviewedSection(
  "一因子の反可換性から得るクロネッカー積の反交換",
  "数学的道具立て",
  singleFactorAnticommutationSectionEntryIds,
  singleFactorAnticommutationExpectedInternalDependencies,
  singleFactorAnticommutationExpectedContentSha256,
  singleFactorAnticommutationExpectedExternalInputEntryIds,
  singleFactorAnticommutationExpectedExternalInputContentSha256,
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site"],
);
const isingModelDefinitionSection = validateReviewedSection(
  "格子と転送行列の定義",
  "2次元イジングモデル",
  isingModelDefinitionSectionEntryIds,
  isingModelDefinitionExpectedInternalDependencies,
  isingModelDefinitionExpectedContentSha256,
  isingModelDefinitionExpectedExternalInputEntryIds,
  isingModelDefinitionExpectedExternalInputContentSha256,
  ["partition_function_2d_ising_003_definition_transfer_matrix"],
);
const isingModelDefinitionExpectedChapterOrders = [1, 2, 3];
const isingModelDefinitionActualChapterOrders = isingModelDefinitionSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(isingModelDefinitionActualChapterOrders) !== JSON.stringify(isingModelDefinitionExpectedChapterOrders)) {
  throw new Error(`格子と転送行列の定義が章内依存順1–3ではありません: ${JSON.stringify(isingModelDefinitionActualChapterOrders)}`);
}
const isingModelDefinitionUnexpectedGranularity = isingModelDefinitionSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (isingModelDefinitionUnexpectedGranularity.length > 0) {
  throw new Error(`格子と転送行列の定義に説明粒度未確認の項目があります: ${isingModelDefinitionUnexpectedGranularity.join(", ")}`);
}
const spinConfigurationBasisSection = validateReviewedSection(
  "スピン配置と標準基底の対応",
  "2次元イジングモデル",
  spinConfigurationBasisSectionEntryIds,
  spinConfigurationBasisExpectedInternalDependencies,
  spinConfigurationBasisExpectedContentSha256,
  spinConfigurationBasisExpectedExternalInputEntryIds,
  spinConfigurationBasisExpectedExternalInputContentSha256,
  ["bridge_001_definition_config_basis"],
);
const spinConfigurationBasisActualChapterOrders = spinConfigurationBasisSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(spinConfigurationBasisActualChapterOrders) !== JSON.stringify([4])) {
  throw new Error(`スピン配置と標準基底の対応が章内依存順4ではありません: ${JSON.stringify(spinConfigurationBasisActualChapterOrders)}`);
}
const spinConfigurationBasisUnexpectedGranularity = spinConfigurationBasisSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (spinConfigurationBasisUnexpectedGranularity.length > 0) {
  throw new Error(`スピン配置と標準基底の対応に説明粒度未確認の項目があります: ${spinConfigurationBasisUnexpectedGranularity.join(", ")}`);
}
const firstOpenChainEntry = entries.find((entry) => entry.id === "closing_005_definition_open_chain_spin_energy")!;
if (firstOpenChainEntry.dependencyPlacement!.chapterOrder !== 5) {
  throw new Error(`スピン配置と標準基底の対応の次項が章内依存順5ではありません: ${firstOpenChainEntry.dependencyPlacement!.chapterOrder}`);
}
if (JSON.stringify([...firstOpenChainEntry.dependsOnEntryIds].sort()) !== JSON.stringify([
  "calculation_formulae_definition_set_and_algebra_notation",
  "partition_function_2d_ising_003_definition_transfer_matrix",
])) {
  throw new Error(`スピン配置と標準基底の対応の次項の直接依存が変わりました: ${JSON.stringify(firstOpenChainEntry.dependsOnEntryIds)}`);
}
if (firstOpenChainEntry.dependsOnEntryIds.includes("bridge_001_definition_config_basis")) {
  throw new Error("スピン配置と標準基底の対応の次項から前節への依存が生じました");
}
if (firstOpenChainEntry.explanationGranularityReview.inspectedContentSha256
  !== openChainSpinSumsExpectedContentSha256.get("closing_005_definition_open_chain_spin_energy")) {
  throw new Error("スピン配置と標準基底の対応の次項本文が変わりました");
}
const openChainSpinSumsSection = validateReviewedSection(
  "1次元開鎖のスピン和",
  "2次元イジングモデル",
  openChainSpinSumsSectionEntryIds,
  openChainSpinSumsExpectedInternalDependencies,
  openChainSpinSumsExpectedContentSha256,
  openChainSpinSumsExpectedExternalInputEntryIds,
  openChainSpinSumsExpectedExternalInputContentSha256,
  ["closing_005_claim_open_chain_spin_sums_positive"],
);
const openChainSpinSumsActualChapterOrders = openChainSpinSumsSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(openChainSpinSumsActualChapterOrders) !== JSON.stringify([5, 6, 7, 8])) {
  throw new Error(`1次元開鎖のスピン和が章内依存順5–8ではありません: ${JSON.stringify(openChainSpinSumsActualChapterOrders)}`);
}
const openChainSpinSumsUnexpectedGranularity = openChainSpinSumsSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (openChainSpinSumsUnexpectedGranularity.length > 0) {
  throw new Error(`1次元開鎖のスピン和に説明粒度未確認の項目があります: ${openChainSpinSumsUnexpectedGranularity.join(", ")}`);
}
const openChainSpinSumsSectionIdSet = new Set<string>(openChainSpinSumsSectionEntryIds);
for (const nextEntryId of [
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
]) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnOpenChainSection = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => openChainSpinSumsSectionIdSet.has(dependencyId));
  if (dependenciesOnOpenChainSection.length > 0) {
    throw new Error(`1次元開鎖のスピン和の次の項目から節内への依存が生じました: ${nextEntryId}: ${JSON.stringify(dependenciesOnOpenChainSection)}`);
  }
}
const partitionFunctionTraceSection = validateReviewedSection(
  "分配関数の転送行列表示",
  "2次元イジングモデル",
  partitionFunctionTraceSectionEntryIds,
  partitionFunctionTraceExpectedInternalDependencies,
  partitionFunctionTraceExpectedContentSha256,
  partitionFunctionTraceExpectedExternalInputEntryIds,
  partitionFunctionTraceExpectedExternalInputContentSha256,
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix"],
);
const partitionFunctionTraceActualChapterOrders = partitionFunctionTraceSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(partitionFunctionTraceActualChapterOrders) !== JSON.stringify([9])) {
  throw new Error(`分配関数の転送行列表示が章内依存順9ではありません: ${JSON.stringify(partitionFunctionTraceActualChapterOrders)}`);
}
const partitionFunctionTraceUnexpectedGranularity = partitionFunctionTraceSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (partitionFunctionTraceUnexpectedGranularity.length > 0) {
  throw new Error(`分配関数の転送行列表示に説明粒度未確認の項目があります: ${partitionFunctionTraceUnexpectedGranularity.join(", ")}`);
}
const partitionFunctionTraceSectionIdSet = new Set<string>(partitionFunctionTraceSectionEntryIds);
for (const nextEntryId of [
  "transfer_matrix_001_definition_symbols",
  "bridge_002_claim_sigma_z_diagonal_action",
]) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnPartitionFunctionTrace = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => partitionFunctionTraceSectionIdSet.has(dependencyId));
  if (dependenciesOnPartitionFunctionTrace.length > 0) {
    throw new Error(`分配関数の転送行列表示の次の項目から節内への依存が生じました: ${nextEntryId}: ${JSON.stringify(dependenciesOnPartitionFunctionTrace)}`);
  }
}
const v1PauliRepresentationSection = validateReviewedSection(
  "V1 のパウリ行列表示",
  "2次元イジングモデル",
  v1PauliRepresentationSectionEntryIds,
  v1PauliRepresentationExpectedInternalDependencies,
  v1PauliRepresentationExpectedContentSha256,
  v1PauliRepresentationExpectedExternalInputEntryIds,
  v1PauliRepresentationExpectedExternalInputContentSha256,
  ["bridge_004_claim_V1_component_equals_pauli"],
);
const v1PauliRepresentationActualChapterOrders = v1PauliRepresentationSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(v1PauliRepresentationActualChapterOrders) !== JSON.stringify([10, 11, 12])) {
  throw new Error(`V1 のパウリ行列表示が章内依存順10–12ではありません: ${JSON.stringify(v1PauliRepresentationActualChapterOrders)}`);
}
for (const entry of v1PauliRepresentationSection.sectionEntries) {
  const actualDependencies = [...entry.dependsOnEntryIds].sort();
  const expectedDependencies = [...v1PauliRepresentationExpectedDirectDependencies.get(entry.id)!].sort();
  if (JSON.stringify(actualDependencies) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`V1 のパウリ行列表示の直接依存が変わりました: ${entry.id}: ${JSON.stringify(actualDependencies)}`);
  }
}
const v1PauliRepresentationUnresolvedGranularity = v1PauliRepresentationSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (JSON.stringify(v1PauliRepresentationUnresolvedGranularity)
  !== JSON.stringify(["transfer_matrix_001_definition_symbols"])) {
  throw new Error(`V1 のパウリ行列表示の説明粒度判定が変わりました: ${JSON.stringify(v1PauliRepresentationUnresolvedGranularity)}`);
}
const v1PauliRepresentationUnresolvedExternalInputGranularity = v1PauliRepresentationSection.externalInputEntryIds
  .map((id) => entries.find((entry) => entry.id === id)!)
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (JSON.stringify(v1PauliRepresentationUnresolvedExternalInputGranularity) !== JSON.stringify([
  "calculation_formulae_definition_set_and_algebra_notation",
  "calc_formulae_006_definition_of_cc",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "bridge_003_claim_exp_of_diagonal",
  "transfer_matrix_005_definition_end_isomorphism",
])) {
  throw new Error(`V1 のパウリ行列表示の外部入力の説明粒度判定が変わりました: ${JSON.stringify(v1PauliRepresentationUnresolvedExternalInputGranularity)}`);
}
const v1PauliRepresentationSectionIdSet = new Set<string>(v1PauliRepresentationSectionEntryIds);
for (const [nextEntryId, expectedDependenciesOnSection] of [
  ["bridge_005_claim_two_by_two_transfer_identity", ["transfer_matrix_001_definition_symbols"]],
  ["bridge_006_claim_V2_component_equals_pauli", ["transfer_matrix_001_definition_symbols"]],
  ["bridge_007_claim_partition_function_in_pauli_form", ["bridge_004_claim_V1_component_equals_pauli", "transfer_matrix_001_definition_symbols"]],
] as const) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnV1PauliRepresentation = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => v1PauliRepresentationSectionIdSet.has(dependencyId));
  if (JSON.stringify(dependenciesOnV1PauliRepresentation) !== JSON.stringify(expectedDependenciesOnSection)) {
    throw new Error(`V1 のパウリ行列表示の次の項目から節内への依存が変わりました: ${nextEntryId}: ${JSON.stringify(dependenciesOnV1PauliRepresentation)}`);
  }
}
const v2PauliPartitionFunctionSection = validateReviewedSection(
  "V2 のパウリ行列表示と分配関数への接続",
  "2次元イジングモデル",
  v2PauliPartitionFunctionSectionEntryIds,
  v2PauliPartitionFunctionExpectedInternalDependencies,
  nextIsingBoundaryComparisonExpectedContentSha256,
  v2PauliPartitionFunctionExpectedExternalInputEntryIds,
  nextIsingBoundaryComparisonExpectedInputContentSha256,
  ["bridge_007_claim_partition_function_in_pauli_form"],
);
const v2PauliPartitionFunctionActualChapterOrders = v2PauliPartitionFunctionSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(v2PauliPartitionFunctionActualChapterOrders) !== JSON.stringify([13, 14, 15])) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続が章内依存順13–15ではありません: ${JSON.stringify(v2PauliPartitionFunctionActualChapterOrders)}`);
}
const v2PauliPartitionFunctionUnexpectedGranularity = v2PauliPartitionFunctionSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (v2PauliPartitionFunctionUnexpectedGranularity.length > 0) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続に説明粒度未確認の項目があります: ${v2PauliPartitionFunctionUnexpectedGranularity.join(", ")}`);
}
const epsilonProjectorsEntry = entries.find((entry) => entry.id === "bridge_008_definition_epsilon_projectors")!;
if (epsilonProjectorsEntry.dependencyPlacement!.chapterOrder !== 16
  || JSON.stringify([...epsilonProjectorsEntry.dependsOnEntryIds].sort()) !== JSON.stringify([
    "calc_formulae_006_definition_of_cc",
    "transfer_matrix_001_definition_symbols",
  ])) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続の次項が変わりました: ${JSON.stringify({
    chapterOrder: epsilonProjectorsEntry.dependencyPlacement!.chapterOrder,
    dependencies: epsilonProjectorsEntry.dependsOnEntryIds,
  })}`);
}
if (epsilonProjectorsEntry.explanationGranularityReview.inspectedContentSha256
  !== "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890") {
  throw new Error("V2 のパウリ行列表示と分配関数への接続の次項本文が変わりました");
}
const v2PauliPartitionFunctionSectionIdSet = new Set<string>(v2PauliPartitionFunctionSectionEntryIds);
const epsilonProjectorDependenciesOnPreviousSection = epsilonProjectorsEntry.dependsOnEntryIds
  .filter((id) => v2PauliPartitionFunctionSectionIdSet.has(id));
if (epsilonProjectorDependenciesOnPreviousSection.length > 0) {
  throw new Error(`射影子の定義から直前節への依存が生じました: ${JSON.stringify(epsilonProjectorDependenciesOnPreviousSection)}`);
}
const epsilonProjectorDefinitionSection = validateReviewedSection(
  "全スピン反転行列から定める二つの行列",
  "2次元イジングモデル",
  epsilonProjectorDefinitionSectionEntryIds,
  epsilonProjectorDefinitionExpectedInternalDependencies,
  epsilonProjectorDefinitionExpectedContentSha256,
  epsilonProjectorDefinitionExpectedExternalInputEntryIds,
  epsilonProjectorDefinitionExpectedExternalInputContentSha256,
  ["bridge_008_definition_epsilon_projectors"],
);
if (epsilonProjectorDefinitionSection.sectionEntries[0]!.dependencyPlacement!.chapterOrder !== 16) {
  throw new Error("全スピン反転行列から定める二つの行列が章内依存順16ではありません");
}
const kappaDefinitionSection = validateReviewedSection(
  "臨界条件からの差を表す実数",
  "2次元イジングモデル",
  kappaDefinitionSectionEntryIds,
  kappaDefinitionExpectedInternalDependencies,
  kappaDefinitionExpectedContentSha256,
  kappaDefinitionExpectedExternalInputEntryIds,
  kappaDefinitionExpectedExternalInputContentSha256,
  ["critical_002_definition_kappa"],
);
const criticalSinhProductDefinitionSection = validateReviewedSection(
  "二つの双曲線正弦の積",
  "2次元イジングモデル",
  criticalSinhProductDefinitionSectionEntryIds,
  criticalSinhProductDefinitionExpectedInternalDependencies,
  criticalSinhProductDefinitionExpectedContentSha256,
  criticalSinhProductDefinitionExpectedExternalInputEntryIds,
  criticalSinhProductDefinitionExpectedExternalInputContentSha256,
  ["critical_002a_definition_critical_sinh_product_A"],
);
const kappaDefinitionEntry = kappaDefinitionSection.sectionEntries[0]!;
const criticalSinhProductDefinitionEntry = criticalSinhProductDefinitionSection.sectionEntries[0]!;
const symmetrizedTransferMatrixEntry = entries.find((entry) => entry.id === "maxeig_001_definition_symmetrized_transfer_matrix")!;
const traceOfSymmetrizedTransferMatrixEntry = entries.find((entry) => entry.id === "maxeig_002_claim_Z_equals_trace_of_W")!;
if (kappaDefinitionEntry.dependencyPlacement!.chapterOrder !== 17
  || criticalSinhProductDefinitionEntry.dependencyPlacement!.chapterOrder !== 18
  || symmetrizedTransferMatrixEntry.dependencyPlacement!.chapterOrder !== 19
  || traceOfSymmetrizedTransferMatrixEntry.dependencyPlacement!.chapterOrder !== 20
  || !traceOfSymmetrizedTransferMatrixEntry.dependsOnEntryIds.includes(symmetrizedTransferMatrixEntry.id)) {
  throw new Error(`臨界条件用実数から対称化転送行列とトレース公式までの章内順が変わりました: ${JSON.stringify({
    kappaOrder: kappaDefinitionEntry.dependencyPlacement!.chapterOrder,
    criticalSinhProductOrder: criticalSinhProductDefinitionEntry.dependencyPlacement!.chapterOrder,
    definitionOrder: symmetrizedTransferMatrixEntry.dependencyPlacement!.chapterOrder,
    traceFormulaOrder: traceOfSymmetrizedTransferMatrixEntry.dependencyPlacement!.chapterOrder,
    traceFormulaDependencies: traceOfSymmetrizedTransferMatrixEntry.dependsOnEntryIds,
  })}`);
}
if (symmetrizedTransferMatrixEntry.explanationGranularityReview.inspectedContentSha256
    !== "283cfe7ca21f59fcd026567e6c76ffad08f1ae9912092f3691fc9571c01d40e2"
  || traceOfSymmetrizedTransferMatrixEntry.explanationGranularityReview.inspectedContentSha256
    !== "498e5bb8b0b5117cb55e8791e72d116d8ff6beed09540a3922ef1650a0cd9a35") {
  throw new Error("臨界条件用実数、対称化転送行列、または直後のトレース公式の本文が変わりました");
}
for (const [entry, expectedDependencies, description] of [
  [symmetrizedTransferMatrixEntry, symmetrizedTransferMatrixExpectedDirectDependencies, "対称化転送行列"],
  [traceOfSymmetrizedTransferMatrixEntry, traceOfSymmetrizedTransferMatrixExpectedDirectDependencies, "対称化転送行列のトレース公式"],
] as const) {
  const actualDependencies = [...entry.dependsOnEntryIds].sort();
  if (JSON.stringify(actualDependencies) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`${description}の直接依存が変わりました: ${JSON.stringify(actualDependencies)}`);
  }
}
if (kappaDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || criticalSinhProductDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || symmetrizedTransferMatrixEntry.explanationGranularityReview.status !== "具体的な行列計算への展開またはブロック分割を要する"
  || epsilonProjectorDefinitionSection.sectionEntries[0]!.explanationGranularityReview.status !== "自動検査で主題に適合"
  || traceOfSymmetrizedTransferMatrixEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error("章内依存順16–20の説明粒度判定が変わりました");
}
const mathematicalToolSectionBoundaries = [{
  name: "行列指数関数による共役の級数公式",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixExponentialConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の四則演算、交換子作用とその二項展開",
    "行列ノルムと完備性",
    "実数・行列・行列作用の指数級数、その収束、可換行列の指数関数の積公式",
  ],
  externalInputEntryIds: matrixExponentialConjugationExternalInputEntryIds,
  output: [
    "行列指数関数による共役を反復交換子の指数級数で表す主定理",
    "主定理の右辺を項ごとに明示する系",
  ],
  mainTheorem: "行列版の指数関数による共役公式",
  mainTheoremEntryId: "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  concludingCorollary: "主定理の反復交換子級数を項ごとに明示する系",
  concludingCorollaryEntryId: "exp_conjugation_proof_008_theorem_exp_ad_series",
  boundaryEvidence: "章内依存順の連続する二項であり、行列版の共役公式を主定理とし、その右辺を項ごとに明示する系で節を閉じる。外部入力・内部依存辺・本文 fingerprint・連続性・節末の一意性を生成時に固定検査する。",
  readabilityStatus: "二項とも具体的な行列計算への展開またはブロック分割を要するため、節境界だけを確定し、本文完成とは扱わない。",
}, {
  name: "行列と線型写像の対応",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixLinearMapCorrespondenceSectionEntryIds,
  input: [
    "複素数、有限複素行列、数ベクトル、線型写像",
    "具体的なクロネッカー積、その積と多重線型性、クロネッカー積で作る行列単位と数ベクトルの基底",
    "行列と線型写像の指数級数",
  ],
  externalInputEntryIds: matrixLinearMapCorrespondenceExternalInputEntryIds,
  output: [
    "行列単位を基底上の線型写像へ送る写像の具体的な定義",
    "その写像が積と単位元を保つ全単射であるという主定理",
    "クロネッカー積で作る行列が各因子の数ベクトルへ成分ごとに作用する公式",
    "行列表示と線型写像表示の間で指数関数が保たれる系",
  ],
  mainTheorem: "行列表示から線型写像表示への写像は単位的な複素代数の同型である",
  mainTheoremEntryId: "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  concludingCorollary: "行列表示と線型写像表示の間で指数関数が保たれる系",
  concludingCorollaryEntryId: "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  boundaryEvidence: "章内依存順の連続する四項であり、対応の定義から積と単位元を保つ全単射という主定理へ進み、クロネッカー積の作用公式と指数関数保存の系という二つの出力で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、二つの節末出力を生成時に固定検査する。",
  readabilityStatus: "四項とも線型写像の抽象語彙を含むため、節境界だけを確定し、定義内の基底・基底作用・対応の分割を含む本文完成とは扱わない。",
}, {
  name: "可逆行列と共役写像",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: invertibleMatrixConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の和・積・単位行列",
    "具体的なクロネッカー積の積と多重線型性、およびクロネッカー積で作る行列単位の基底",
    "スカラー倍した単位行列が全行列と可換すること",
    "全行列と可換する複素行列がスカラー倍した単位行列に限ること",
  ],
  externalInputEntryIds: invertibleMatrixConjugationExternalInputEntryIds,
  output: [
    "可逆行列と逆行列の具体的な定義および積・逆元・スカラー単位行列に関する基本性質",
    "可逆行列による共役写像の定義",
    "可逆行列全体の中で全可逆行列と可換する元が非零スカラー倍の単位行列に限ること",
    "二つの共役写像が等しいことと、それらを定める可逆行列が非零スカラー倍だけ異なることの同値",
  ],
  mainTheorem: "可逆行列による共役写像は、それを定める行列の非零スカラー倍を除いて単射である",
  mainTheoremEntryId: "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  boundaryEvidence: "章内依存順の連続する四項であり、可逆元の定義から共役写像の定義と可逆行列全体の可換元の特徴付けへ進み、両者を使う定数倍を除いた単射性の主定理で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "四項とも複素数と有限行列の具体的な計算で書かれ、現行の説明粒度検査に合格している。未定義だった特性多項式・固有値・行列式による可逆化を削除し、明示的な逆行列をもつ行列単位の摂動だけを使う証明へ置き換えた。",
}, {
  name: "Pauli 行列と共役で保たれる行列群",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: pauliAndCliffordMatrixGroupsSectionEntryIds,
  input: [
    "複素数と二次の複素行列の成分表示および行列積",
    "具体的なクロネッカー積の積と多重線型性",
    "有限複素行列の可逆元と逆行列",
  ],
  externalInputEntryIds: pauliAndCliffordMatrixGroupsSection.externalInputEntryIds,
  output: [
    "三つの Pauli 行列の平方と相互の反可換性を成分で確かめる積公式",
    "Pauli 行列のクロネッカー積と四乗根の係数からなる有限な行列群の定義",
    "その行列群を共役で保つ可逆行列全体の定義",
  ],
  mainTheorem: null,
  mainTheoremEntryId: null,
  concludingDefinition: "Pauli 行列群を共役で保つ可逆行列全体",
  concludingDefinitionEntryId: "TV1_hatZ_hatY_010_definition_clifford_group",
  boundaryEvidence: "章内依存順の連続する三項であり、Pauli 行列の積公式から多因子の Pauli 行列群を定め、その行列群を共役で保つ可逆行列全体の定義へ閉じる。直後の一因子反可換性はこの行列群を使わず、外部入力も可逆元を含まない独立した帰結なので別節とする。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末定義の一意性を生成時に固定検査する。",
  readabilityStatus: "Pauli 行列群とクリフォード行列群を別ブロックへ分け、後者からイジング模型固有の V_2 による導入理由を除いた。二つの行列群について群の閉性を具体的な行列計算へさらに展開する余地があるため、本文完成とは扱わない。",
}, {
  name: "一因子の反可換性から得るクロネッカー積の反交換",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: singleFactorAnticommutationSectionEntryIds,
  input: [
    "複素数と二次の複素行列",
    "具体的なクロネッカー積の積と各因子についての多重線型性",
    "一つの因子での反可換性と残りの因子での可換性",
  ],
  externalInputEntryIds: singleFactorAnticommutationSection.externalInputEntryIds,
  output: [
    "一因子だけの負号がクロネッカー積全体の負号となり、二つの多因子行列が反交換する公式",
  ],
  mainTheorem: "一因子だけ反可換で他の因子が可換なら、二つのクロネッカー積は反交換する",
  mainTheoremEntryId: "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  boundaryEvidence: "直前の行列群の定義に依存せず、クロネッカー積の積と多重線型性だけを外部入力として一つの主張へ閉じる独立した葉である。したがって行列群の節へ混ぜず、一項の節として確定する。外部入力とその本文 fingerprint、本文 fingerprint、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "二次の複素行列とクロネッカー積の積を一因子ずつ書いた具体的な計算であり、現行の説明粒度検査に合格している。",
}];
const isingModelSectionBoundaries = [{
  name: "格子と転送行列の定義",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: isingModelDefinitionSectionEntryIds,
  input: [
    "自然数と実数・複素数の集合記号",
    "有限複素行列の成分表示",
  ],
  externalInputEntryIds: isingModelDefinitionSection.externalInputEntryIds,
  output: [
    "格子の縦横の大きさ",
    "周期境界条件をもつ2次元イジング模型の分配関数",
    "一行分のスピン配置を添え字とする二つの転送行列",
  ],
  concludingDefinition: "2次元イジング模型の分配関数を行列積へ移すための転送行列",
  concludingDefinitionEntryId: "partition_function_2d_ising_003_definition_transfer_matrix",
  boundaryEvidence: "章内依存順の連続する三項であり、格子サイズを分配関数が意味的前提として明示し、分配関数を転送行列が周期境界条件の参照先として使う。格子サイズから転送行列までが模型の有限サイズ表現を定め、次の転送行列による分配関数の表式へ入力を渡すため、三つの定義で最初の節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末定義の一意性を生成時に固定検査する。",
  readabilityStatus: "三項とも有限集合、有限和、有限複素行列の成分として具体的に定義され、現行の説明粒度検査に合格している。",
}, {
  name: "スピン配置と標準基底の対応",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: spinConfigurationBasisSectionEntryIds,
  input: [
    "最初の節で定めた一行分のスピン配置と転送行列",
    "クロネッカー積の標準基底を番号づける多重添字と、その多重添字による行列成分の表示",
  ],
  externalInputEntryIds: spinConfigurationBasisSection.externalInputEntryIds,
  output: [
    "一行分のスピン配置から多重添字への全単射",
    "スピン配置を添え字として転送行列の成分を読むための具体的な対応",
  ],
  concludingDefinition: "スピン配置からクロネッカー積の標準基底の多重添字への全単射",
  concludingDefinitionEntryId: "bridge_001_definition_config_basis",
  boundaryEvidence: "章内依存順4の一項は、最初の節で定めた転送行列と、数学的道具立ての標準基底・行列表示の対応を入力として、スピン配置から多重添字への全単射を定める。次の章内依存順5は、転送行列定義のスピン配置集合を別の行長記号で読み替えて開鎖エネルギーを定めるが、順4の標準基底との対応には依存せず、外部入力集合も異なる。したがって外部入力集合が変わる章内依存順4の後でこの一項の節を閉じる。外部入力とその本文 fingerprint、本文 fingerprint、章内依存順、節末定義の一意性に加え、次項の章内順・直接依存・本文 fingerprint・前節からの非依存を生成時に固定検査する。",
  readabilityStatus: "対象定義は有限集合の各成分について二通りの値を対応させ、転送行列の行・列を具体的に読み替えるため、現行の説明粒度検査に合格している。外部入力である行列と線型写像の対応の節には、具体的な行列計算への展開またはブロック分割が残る。",
}, {
  name: "1次元開鎖のスピン和",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: openChainSpinSumsSectionEntryIds,
  input: [
    "最初の節で定めた一行分のスピン配置",
    "双曲線関数の定義・基本性質と指数関数の積公式",
    "有限集合と有限和の記号",
  ],
  externalInputEntryIds: openChainSpinSumsSection.externalInputEntryIds,
  output: [
    "1次元開鎖のスピン配置集合と開鎖エネルギー",
    "端点因子を持たない1次元開鎖のスピン和と、両端のスピンの積を掛けたスピン和の閉じた式",
    "正の結合定数に対する二つのスピン和の正値性",
  ],
  mainTheorem: "端点因子のないスピン和と両端のスピンの積を掛けたスピン和を双曲線関数で表す二公式",
  mainTheoremEntryIds: [
    "closing_005_claim_open_chain_partition_sum",
    "closing_005_claim_open_chain_endpoint_product_sum",
  ],
  concludingClaim: "正の結合定数に対する二つの1次元開鎖のスピン和の正値性",
  concludingClaimEntryId: "closing_005_claim_open_chain_spin_sums_positive",
  boundaryEvidence: "旧来一ブロックだった内容を、共通記法、端点因子のない和、両端積付きの和、正値性の四項へ分けた章内依存順5–8の連続区間である。二つの和は共通記法だけに依存し、正値性が二公式を受け取って節末を閉じる。章内依存順9の転送行列による分配関数の表式および章内依存順10の記号の定義はこの節へ依存せず、節末を含む三項の外部入力集合もそれぞれ異なる。したがって外部入力集合が切り替わる章内依存順8の後で節を閉じる。外部入力とその本文 fingerprint、四項の本文 fingerprint、内部依存辺、章内依存順、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "共通記法と三つの主張を分離し、二公式は初期スピンと隣接スピンの積への具体的な全単射で有限和を計算しているため、対象四項は現行の説明粒度検査に合格している。外部入力である集合と代数構造の記号、双曲線関数の基本性質、可換行列の指数積公式には、複数の定義・主張の分割または具体的な行列計算への展開が残る。",
}, {
  name: "分配関数の転送行列表示",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: partitionFunctionTraceSectionEntryIds,
  input: [
    "最初の節で定めた周期境界条件つき分配関数と二つの転送行列",
    "有限複素行列の積・冪・トレース",
    "可換な指数関数の積公式と有限和・有限積の計算規則",
  ],
  externalInputEntryIds: partitionFunctionTraceSection.externalInputEntryIds,
  output: [
    "2次元イジング模型の分配関数を転送行列の積の冪のトレースとして表す公式",
  ],
  mainTheorem: "2次元イジング模型の分配関数は二つの転送行列の積の冪のトレースに等しい",
  mainTheoremEntryId: "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  boundaryEvidence: "章内依存順9の一項は、最初の節で定めた分配関数と転送行列を入力として、有限行列の成分・冪・トレースを展開し、分配関数の転送行列表示という一つの主張へ閉じる。章内依存順10の記号の定義と順11のσzの基底作用はこの主張へ依存せず、順10は別の行列指数関数とクロネッカー積を入力とし、順11は順10とスピン配置・標準基底の対応を入力とする。したがって外部入力集合が切り替わる章内依存順9の後で一項の節を閉じる。外部入力とその本文 fingerprint、対象本文 fingerprint、章内依存順、節末出力の一意性に加え、次の二項の章内順・直接依存・本文 fingerprint・本節からの非依存を生成時に固定検査する。",
  readabilityStatus: "対象主張は有限集合上の和、有限複素行列の積と冪、トレースを一段ずつ展開しているため、現行の説明粒度検査に合格している。外部入力である集合と代数構造の記号、複素数の定義、可換行列の指数積公式には、複数の定義・主張の分割または具体的な行列計算への展開が残る。",
}, {
  name: "V1 のパウリ行列表示",
  chapter: "2次元イジングモデル",
  status: "境界候補・対象本文粒度未解決・外部入力粒度未解決",
  entryIds: v1PauliRepresentationSectionEntryIds,
  input: [
    "最初の節で成分表示により定めた転送行列 V1",
    "スピン配置とクロネッカー積の標準基底の多重添字との対応",
    "二次の Pauli 行列、サイトごとのクロネッカー積、その積・多重線型性・基底作用",
    "実数の双曲線余弦・双曲線正弦の定義と正値性",
    "有限複素行列の指数関数と対角行列の指数関数",
  ],
  externalInputEntryIds: v1PauliRepresentationSection.externalInputEntryIds,
  output: [
    "サイトごとの Pauli 行列と V1・V2、Jordan–Wigner 行列、全スピン反転行列、双対結合定数の記号",
    "サイトごとの σz とその二つの積がスピン配置基底へ対角に作用する公式",
    "成分で定義した V1 と Pauli 行列の指数関数で表した V1 が同じ行列であること",
  ],
  mainTheorem: "成分定義の V1 と Pauli 行列による指数表示の一致",
  mainTheoremEntryId: "bridge_004_claim_V1_component_equals_pauli",
  boundaryEvidence: "現行の未分割グラフでは章内依存順10–12が連続し、順10のサイト作用素の記号を順11のσzの基底作用が受け取り、順12がその作用と対角行列の指数関数を用いて、成分定義とPauli行列表示のV1が同じ行列であるという主定理へ閉じるため、順12の後は節境界の候補となる。ただし順10はV1だけでなくV2とJordan–Wigner変換の記号も束ね、順13・14は順10を再利用し、順15は順10と順12を受け取る。順10を一ブロック一定義へ分割すると依存辺と境界が変わりうるため、最終的な節構造は確定しない。生成時には、この暫定評価の前提として、外部入力とその本文 fingerprint、三項の本文 fingerprint、内部依存辺、章内依存順、現行グラフ上の節末出力に加え、章内依存順13–15の章内順・直接依存・本文 fingerprint、および順15がこの候補から順10・12を受け取ることを固定検査する。",
  readabilityStatus: "対象三項のうち、σzの基底作用とV1の二表示の一致は、二次行列の基底作用、クロネッカー積、周期端を分けた対角成分を一段ずつ計算しており、現行の説明粒度検査に合格している。先頭の「記号の定義」は、単位行列、サイトごとの三つのPauli行列、V1・V2、Jordan–Wigner行列、全スピン反転行列、双対結合定数、双曲線関数の略記を一ブロックへ束ねているため未解決である。Pauli行列、cosh・sinh、その正値性は先行項へ明示参照したが、tanh と実対数には独立した先行定義がなく、双対関係の証明は本項を入力とする後続主張なので循環参照を避けた。さらに外部入力では、集合と代数構造の記号、複素数、行列指数関数、対角行列の指数関数、行列と線型写像の対応に説明粒度の未解決が残る。対象側と外部入力側を区別して、境界候補・本文未完成として扱う。",
}, {
  name: "V2 のパウリ行列表示と分配関数への接続",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: v2PauliPartitionFunctionSectionEntryIds,
  input: [
    "双対結合定数 K2* と双曲線関数の略記、およびサイトごとの Pauli 行列と V2 の定義",
    "二次の Pauli 行列、非負実数の平方根、指数関数・双曲線関数の級数と基本性質",
    "スピン配置とクロネッカー積の標準基底の対応、およびクロネッカー積の成分・積・多重線型性",
    "成分表示で定めた転送行列 V2 と、確定済みの V1 の二表示の一致・分配関数の転送行列表示",
  ],
  externalInputEntryIds: v2PauliPartitionFunctionSection.externalInputEntryIds,
  output: [
    "一サイトの二次転送行列を Pauli 行列の指数関数で表す恒等式",
    "成分で定義した V2 と Pauli 行列の指数関数で表した V2 が同じ行列であること",
    "2次元イジング模型の分配関数を Pauli 行列表示の転送行列の積の冪のトレースで表す公式",
  ],
  mainTheorem: "分配関数を Pauli 行列表示の二つの転送行列で表す公式",
  mainTheoremEntryId: "bridge_007_claim_partition_function_in_pauli_form",
  boundaryEvidence: "章内依存順13–15は連続し、二次転送行列の恒等式からV2の二表示の一致へ進み、確定済みのV1の二表示の一致と分配関数の転送行列表示を合わせて、分配関数のPauli行列表示へ一方向に閉じる。次の章内依存順16の射影子定義は全スピン反転行列だけを使い、この三項へ依存しないため、外部入力集合が切り替わる順15の後で節を閉じる。順10の混在した記号定義を分割した後は、順13が双対結合定数と双曲線関数の略記、順14がサイトごとのσxとV2、順15がV1・V2の定義片へ依存することを再判定する。分割によりこれらの意味的依存、三項の連続性、順15への一意な閉包、または順16からの非依存が変わった場合は境界を再確定する。",
  readabilityStatus: "対象三項は、二次行列の指数級数、クロネッカー積の成分と積、二つの転送行列表示の置換を一段ずつ計算しており、現行の説明粒度検査に合格している。外部入力では、混在した記号定義、集合と代数構造の記号、複素数、行列指数関数とその収束・可換積公式、対角行列の指数関数に説明粒度の未解決が残る。とくにtanhと実対数の独立した先行定義は未整備であり、順10の分割時に補う必要がある。",
}, {
  name: "全スピン反転行列から定める二つの行列",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: epsilonProjectorDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる全スピン反転行列",
    "複素数と有限複素行列の単位行列・和・スカラー倍",
  ],
  externalInputEntryIds: epsilonProjectorDefinitionSection.externalInputEntryIds,
  output: [
    "全スピン反転行列と単位行列の和・差から定める二つの行列",
  ],
  concludingDefinition: "全スピン反転行列から作る二つの行列",
  concludingDefinitionEntryId: "bridge_008_definition_epsilon_projectors",
  boundaryEvidence: "章内依存順16の一項は全スピン反転行列だけをイジング固有の入力として二つの行列を定める。次の章内依存順17は双対結合定数と双曲線関数の略記だけを使い、本項へ依存しない。外部入力集合が切り替わるため、順16の後で一項の節を閉じる。これらが固有空間への射影子であることは後続主張で証明するため、本節の出力には含めない。生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、次項の直接依存、および次項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は単位行列と全スピン反転行列の和・差とスカラー倍として具体的に書かれ、現行の説明粒度検査に合格している。外部入力では、混在した記号定義と複素数の定義に説明粒度の未解決が残る。射影子性は章内依存順24の後続主張で証明される。",
}, {
  name: "臨界条件からの差を表す実数",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: kappaDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる二つの正の結合定数と双対結合定数",
    "実数の差とスカラー倍",
  ],
  externalInputEntryIds: kappaDefinitionSection.externalInputEntryIds,
  output: ["二つの結合定数の差を二倍した実数 κ"],
  concludingDefinition: "臨界条件からの差を表す実数 κ",
  concludingDefinitionEntryId: "critical_002_definition_kappa",
  boundaryEvidence: "章内依存順17の一項は結合定数と双対結合定数の差だけから κ を定める。次の章内依存順18は双曲線正弦の積を定めるため基本性質を追加で入力し、κ へ依存しない。外部入力集合が切り替わるため、順17の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末定義の一意性、次項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は二つの正の実数の差と二倍だけで具体的に書かれ、現行の説明粒度検査に合格している。外部入力である混在した記号定義には分割が残る。",
}, {
  name: "二つの双曲線正弦の積",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: criticalSinhProductDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる二つの正の結合定数と双対結合定数",
    "実数の双曲線正弦の定義と正値性",
  ],
  externalInputEntryIds: criticalSinhProductDefinitionSection.externalInputEntryIds,
  output: ["二つの正の双曲線正弦の積 A"],
  concludingDefinition: "二つの双曲線正弦の積 A",
  concludingDefinitionEntryId: "critical_002a_definition_critical_sinh_product_A",
  boundaryEvidence: "章内依存順18の一項は二つの正の双曲線正弦の積 A を定め、その正値性までを同じ定義の well-defined 性として確認する。順17の κ へ依存せず、次の章内依存順19は対称化転送行列を別の行列指数関数入力から定めるため外部入力集合が切り替わる。したがって順18の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末定義の一意性、前後項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は二つの正の実数へ双曲線正弦を適用して積を取る具体的な計算であり、正値性の根拠も明示しているため、現行の説明粒度検査に合格している。外部入力である混在した記号定義と双曲線関数の基本性質には分割が残る。",
}];
const toolEntries = entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^transfer_matrix_claim_end_|^TV1_hatZ_hatY_011|^TV1_hatZ_hatY_009|^TV1_hatZ_hatY_010|^TV1_hatZ_hatY_definition_pauli_group|exp_conjugation_proof_005|^calculation_formulae_046/],
  ["行列指数関数と交換子計算", /^exp_linear_map_|exp_conjugation_proof_(004|008|010)|^bridge_003|^TV1_hatZ_hatY_004/],
  ["数ベクトル・行列の長さと収束", /^linear_space_general_00(2b|2c|3|3b|3c|3d)/],
  ["クロネッカー積と多因子基底", /^linear_space_general_000|^linear_space_general_001/],
  ["有限行列・Pauli行列・交換子", /^linear_space_general_002_|^linear_space_general_004|^Z_Y_anticommutation_|calc_formulae_00[345]|calculation_formulae_047/],
  ["絶対値・偏角・複素平方根", /^calculation_formulae_03[1-9]|^calculation_formulae_04[0-4]/],
  ["角度・極座標・複素数の積と商", /^calc_formulae_01[1-9]|^calculation_formulae_02[2-9]|^calculation_formulae_030/],
  ["集合記号と複素数の直交座標計算", /set_and_algebra_notation|^calc_formulae_00[6-9]|^calc_formulae_010|^calculation_formulae_045|complex_conjugate/],
  ["実数の平方根・指数関数・双曲線関数", /^calc_formulae_000|^calc_formulae_001|^calc_formulae_002|^calc_formulae_definition_cosh_sinh|^critical_001/],
];
const groupOf = (entry: typeof entries[number]): string => {
  const matches = groupRules.filter(([, pattern]) => pattern.test(entry.id)).map(([name]) => name);
  if (matches.length !== 1) throw new Error(`数学的道具の分類規則一致数が1ではありません: ${entry.id}: ${matches.join(", ")}`);
  return matches[0]!;
};
const groupDescriptions = new Map([
  ["集合記号と複素数の直交座標計算", { input: "既知の自然数・整数・実数の集合と実数の四則演算", output: "集合と演算付き構造の区別、複素数を実数対として計算する規則", reason: "冒頭から記号の所属と演算を曖昧にせず、行列成分の計算へ進むため。" }],
  ["実数の平方根・指数関数・双曲線関数", { input: "非負実数と実数の級数", output: "平方根、指数関数、cosh・sinhの計算公式", reason: "行列成分に現れる係数を初等的な実数計算へ戻すため。" }],
  ["角度・極座標・複素数の積と商", { input: "平面上の実数対と円弧", output: "角度、極座標、複素数の積・逆数・商", reason: "複素固有値の位相を図形と四則演算で追うため。" }],
  ["絶対値・偏角・複素平方根", { input: "複素数の極座標表示", output: "絶対値、偏角、平方根とそれらの積・逆数の公式", reason: "固有値の大きさと平方根の枝を明示して計算するため。" }],
  ["クロネッカー積と多因子基底", { input: "2次の複素行列と2次元数ベクトル", output: "具体的なクロネッカー積、その積・転置・基底", reason: "抽象テンソル積を使わず、大きな行列を小さな行列の成分から組み立てるため。" }],
  ["有限行列・Pauli行列・交換子", { input: "有限複素行列と行列積", output: "分解、共役、交換子・反交換子、Pauli行列の積", reason: "後章の全操作を手で追える有限行列の掛け算へ落とすため。" }],
  ["数ベクトル・行列の長さと収束", { input: "複素行列の成分と有限和", output: "成分から定めるノルム、不等式、成分ごとの収束と完備性", reason: "無限級数を使う箇所でも、各成分の誤差を追える形にするため。" }],
  ["行列指数関数と交換子計算", { input: "有限行列、行列積、ノルム収束", output: "行列指数関数、可換積公式、交換子の反復による共役公式", reason: "転送行列の指数表示を、有限行列の級数と積の計算だけで扱うため。" }],
  ["可逆行列・線型写像との対応・共役変換", { input: "可逆な複素行列、行列単位、数ベクトルの基底", output: "行列と作用の一対一対応、逆行列による共役作用、Pauli/Clifford行列群", reason: "行列の式とベクトルへの作用を同じ成分表で行き来し、対称性を左右から掛ける計算で追うため。" }],
  ["トレース・共役転置・正定値性", { input: "複素行列、共役転置、固有ベクトル", output: "トレース公式、Frobenius内積、エルミート性、正定値性とCauchy–Schwarz評価", reason: "最大固有値と重複度を、成分和と二次式の符号から判定するため。" }],
  ["三角関数の評価・有限和・積分", { input: "連続な実数関数、有限和、初等的な三角関数の不等式", output: "リーマン和の極限、積分の閉形式と上下評価", reason: "有限サイズの行列計算から自由エネルギーと臨界挙動を読み取る最後の計算に必要なため。" }],
]);
const mathematicalToolGroups = [...groupDescriptions].map(([name, description]) => ({
  name, ...description,
  entryIds: toolEntries.filter((entry) => groupOf(entry) === name).sort((a, b) => a.dependencyPlacement!.chapterOrder - b.dependencyPlacement!.chapterOrder).map(({ id }) => id),
}));
const groupedToolIds = mathematicalToolGroups.flatMap(({ entryIds }) => entryIds);
if (groupedToolIds.length !== toolEntries.length || new Set(groupedToolIds).size !== toolEntries.length) {
  throw new Error("数学的道具立ての分類群が全項目を一意に被覆していません");
}
const allDependencyLabels = allBlocks.flatMap(({ block }) => [...collectTargets(block)]);
const dependencySupportNodes = allBlocks.filter(({ block }) => !targetIds.has(block.id)).map(({ file, block }) => ({
  id: block.id, kind: block.kind, title: blockTitle(block), labels: block.labels, sourceFile: file,
  dependsOnLabels: [...collectTargets(block)].sort(),
}));
const inventory = {
  schemaVersion: 3,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の全 definition・claim・theorem",
  organizingTheme: "高校生でも読める具体的な複素数・行列計算として2次元イジング模型の厳密解を積み上げる",
  withdrawnBoundaryAxes: ["実数解析への脱出を伴う道具／有限複素行列だけで閉じる道具", "可算／非可算"],
  boundaryRule: "章境界は対象の意味がイジング模型に依存するかだけで定め、解析や集合の濃度は章・節境界に使わない。",
  finalChapters,
  classificationStatus: "全項目の分類・説明粒度・ブロック境界を再検証し、章内依存順と数学的道具立ての分類群を確定済み。",
  entryCount: entries.length,
  chapterEntryCounts: Object.fromEntries(finalChapters.map((chapter) => [chapter, entries.filter((entry) => entry.provisionalFinalChapter === chapter).length])),
  mathematicalToolGroups,
  mathematicalToolSectionBoundaries,
  isingModelSectionBoundaries,
  explanationGranularityReview: {
    reviewedEntryCount: entries.length,
    criterion: "高度な抽象理論を導入せず、複素数と有限行列の具体的な計算を依存先から順に追えること",
    flaggedEntryIds: entries.filter((entry) =>
      entry.explanationGranularityReview.abstractVocabularyMatches.length > 0 || entry.explanationGranularityReview.forwardNavigationMixedIntoStatement || entry.explanationGranularityReview.manualReview !== null
    ).map(({ id }) => id),
  },
  mathematicalToolSemanticContaminationReview: {
    inspectedEntryCount: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て").length,
    contaminatedEntryIds: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て" && entry.classificationEvidence.isingSemanticMatches.length > 0).map(({ id }) => id),
  },
  chapterStructures,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies: [...new Set(allDependencyLabels)].filter((label) => !labelOwners.has(label)).sort(),
  entries, dependencySupportNodes,
};
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
