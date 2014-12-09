%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}


Name:           python-pyvmomi
Version:        999-comodit-5.5.0
Release:        1%{dist}
Url:            https://github.com/vmware/pyvmomi
Summary:        VMware vSphere Python SDK
License:        Apache 2
Group:          Development/Languages/Python
Source:         %{name}-%{version}-1.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires:  python-devel python-setuptools
BuildArch:      noarch

%description
pyVmomi is a Python SDK for the VMware vSphere API that allows you to
manipulate ESX, ESXi, and vCenter using scripts.

%prep
%setup -q -c

%build
export CFLAGS="%{optflags}"
%{__python} setup.py build

%install
python setup.py install --prefix=%{_prefix} --root=%{buildroot}

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%doc License.txt README.md Notice.txt MANIFEST.in
%python_sitelib/pyVmomi*
%python_sitelib/pyVim*
%python_sitelib/*.egg-info

%changelog

