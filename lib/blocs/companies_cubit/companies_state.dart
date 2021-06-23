import 'package:equatable/equatable.dart';
import 'package:twake/models/company/company.dart';

export 'package:twake/models/company/company.dart';

abstract class CompaniesState extends Equatable {
  const CompaniesState();
}

abstract class CompaniesFailureState extends CompaniesState {
  final String message;

  const CompaniesFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

class CompaniesInitial extends CompaniesState {
  const CompaniesInitial();

  @override
  List<Object> get props => [];
}

class CompaniesLoadSuccess extends CompaniesState {
  final List<Company> companies;
  final Company selected;

  const CompaniesLoadSuccess({required this.companies, required this.selected});

  @override
  List<Object> get props => [companies, selected];
}

class CompaniesLoadInProgress extends CompaniesState {
  const CompaniesLoadInProgress();

  @override
  List<Object> get props => [];
}

class CompaniesLoadFailure extends CompaniesFailureState {
  final String message;

  const CompaniesLoadFailure({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class CompaniesSwitchInProgress extends CompaniesState {
  final String selectedCompanyId;

  const CompaniesSwitchInProgress({required this.selectedCompanyId});

  @override
  List<Object> get props => [selectedCompanyId];
}

class CompaniesSwitchSuccess extends CompaniesState {
  final String companyId;

  const CompaniesSwitchSuccess({
    required this.companyId,
  });

  @override
  List<Object> get props => [companyId];
}

class CompaniesSwitchFailure extends CompaniesFailureState {
  final String message;

  const CompaniesSwitchFailure({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
