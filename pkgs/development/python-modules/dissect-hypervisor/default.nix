{ lib
, buildPythonPackage
, defusedxml
, dissect-cstruct
, dissect-util
, fetchFromGitHub
, pycryptodome
, pytestCheckHook
, pythonOlder
, rich
, setuptools
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "dissect-hypervisor";
  version = "3.12";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "fox-it";
    repo = "dissect.hypervisor";
    rev = "refs/tags/${version}";
    hash = "sha256-uQt+oyETjZHPa1QZfswpUX92ZCdzkR5x9deo15J+Fxo=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = [
    defusedxml
    dissect-cstruct
    dissect-util
  ];

  passthru.optional-dependencies = {
    full = [
      pycryptodome
      rich
    ];
  };

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "dissect.hypervisor"
  ];

  meta = with lib; {
    description = "Dissect module implementing parsers for various hypervisor disk, backup and configuration files";
    homepage = "https://github.com/fox-it/dissect.hypervisor";
    changelog = "https://github.com/fox-it/dissect.hypervisor/releases/tag/${version}";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ fab ];
  };
}
