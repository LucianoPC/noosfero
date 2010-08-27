class InvitationJob < Struct.new(:person_id, :contacts_to_invite, :message, :profile_id, :contact_list_id)
  def perform
    person = Person.find(person_id)
    profile = Profile.find(profile_id)
    Invitation.invite(person, contacts_to_invite, message, profile)
    ContactList.find(contact_list_id).destroy
  end
end
